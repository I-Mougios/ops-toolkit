import json
import subprocess
import argparse
import sys


def get_github_deployments(owner, repo):
    # Call GitHub CLI to get deployments
    result = subprocess.run(["gh", "api", f"/repos/{owner}/{repo}/deployments"], capture_output=True, text=True)

    if result.returncode != 0:
        print("Error:", result.stderr)
        sys.exit(1)

    return sorted(json.loads(result.stdout), key=lambda k: k["created_at"])


def delete_github_deployment(owner, repo, id):
    result = subprocess.run(
        ["gh", "api", "--method", "DELETE", f"/repos/{owner}/{repo}/deployments/{id}"], capture_output=True, text=True
    )

    if result.returncode != 0:
        print("Failed to delete deployment:", result.stderr)
    else:
        print("Successfully deleted deployment:".format(id))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetch GitHub deployments for a repository")

    # Add arguments
    parser.add_argument("--owner", type=str, default="I-Mougios", required=False, help="Owner of the GitHub repository")

    parser.add_argument("--repo", type=str, default="ops-toolkit", required=False, help="Name of the GitHub repository")

    parser.add_argument("-d", "--delete", action="store_true", help="Delete deployments instead of listing them")

    parser.add_argument("--ids", nargs="*", type=int, help="List of deployment IDs to delete")

    args = parser.parse_args()

    if args.delete:
        if not args.ids:
            ids = [int(deployment_info["id"]) for deployment_info in get_github_deployments(args.owner, args.repo)]
            args.ids = ids

        confirm_deletion = input(f"Are you sure you want to delete deployments {args.ids}? [y/N] : ")
        if confirm_deletion.lower() != "y":
            sys.exit(1)

        for deployment_id in args.ids:
            delete_github_deployment(args.owner, args.repo, deployment_id)
    else:
        deployments = get_github_deployments(args.owner, args.repo)
        print(json.dumps(deployments, indent=2))
        sys.exit(0)
