from __future__ import annotations

import re
import subprocess
import unicodedata
from datetime import date

from copier_templates_extensions import ContextHook
from jinja2.ext import Extension


def git_user_name(default: str) -> str:
    return subprocess.getoutput("git config user.name").strip() or default


def git_user_email(default: str) -> str:
    return subprocess.getoutput("git config user.email").strip() or default


def slugify(value, separator="-"):
    value = unicodedata.normalize("NFKD", str(value)).encode("ascii", "ignore").decode("ascii")
    value = re.sub(r"[^\w\s-]", "", value.lower())
    return re.sub(r"[-_\s]+", separator, value).strip("-_")


class GitExtension(Extension):
    def __init__(self, environment):
        super().__init__(environment)
        environment.filters["git_user_name"] = git_user_name
        environment.filters["git_user_email"] = git_user_email


class SlugifyExtension(Extension):
    def __init__(self, environment):
        super().__init__(environment)
        environment.filters["slugify"] = slugify


class CurrentYearExtension(Extension):
    def __init__(self, environment):
        super().__init__(environment)
        environment.globals["current_year"] = date.today().year


class GitHubIDsforGiscusExtension(ContextHook):
    repo_placeholder = "REPLACE WITH REPOSITORY NODE ID"
    category_placeholder = "REPLACE WITH DISCUSSION CATEGORY ID"
    update = False
    query = """                     
    {
        repository(owner: "%(owner)s", name: "%(name)s") {
            discussionCategories(first: 100) {
                nodes {
                    id
                    name
                }
            }
        }
    }
    """

    repo_id: str | None = None
    category_id: str | None = None

    def hook(self, context):
        repository_namespace = context["repository_namespace"]
        repository_name = context["repository_name"]
    
        if self.repo_id is None:
            command = f"gh api repos/{repository_namespace}/{repository_name} --jq .node_id"
            self.repo_id = subprocess.getoutput(command).strip() or self.repo_placeholder
        context["giscus_repo_id"] = self.repo_id

        if self.category_id is None:
            jq_filter = "--jq '.data.repository.discussionCategories.nodes[] | select(.name == \"Documentation\") | .id'"
            command = f"gh api graphql -f query='{self.query}' {jq_filter}" % {"owner": repository_namespace, "name": repository_name}
            self.category_id = subprocess.getoutput(command).strip() or self.category_placeholder
        context["giscus_discussion_category_id"] = self.category_id
