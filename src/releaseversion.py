import argparse
import os
import shutil
import subprocess
import sys

import colorama
from colorama import Fore, Style

import xml.etree.ElementTree as ET

# --------------------------------------------

#--- Generic Paths ---
SRC_GIT_DIR = os.path.abspath(os.environ["BUILD_GIT_DIR"] + "/src")

# --------------------------------------------

def check_tag_exist(tagname):
    proc = subprocess.Popen(["git", "tag"], stdout=subprocess.PIPE, shell=True)
    (out, err) = proc.communicate()
    list_tag = out.decode("utf-8")
    list_tag = list_tag.split()
    if any(tagname in s for s in list_tag):
        return True
    else:
        return False

# --------------------------------------------


def git_reset():
    subprocess.run(["git", "reset"], check=True)

# --------------------------------------------


def git_clean():
    subprocess.run(["git", "clean", "-fx", "-d", "-f"], check=True)
# --------------------------------------------


def git_pull():
    print("log1: ",os.getcwd())
    subprocess.run(["git", "pull"], check=True)


# --------------------------------------------


def git_checkout(branch):
    subprocess.run(["git", "checkout", branch],  check=True)

# --------------------------------------------

def get_version(path):
    os.chdir(path)
    version = ""
    if(os.path.exists('package.xml')):
        print("exists package.xml")
        mytree = ET.parse('package.xml')
        myroot = mytree.getroot()
        version = myroot.find('version').text
        print("verision ", version)
    return version

# --------------------------------------------

def get_message_log():
    message = commit_message(os.environ["BUILD_GIT_DIR"])
    return message

# --------------------------------------------


def git_pull_master(path, branch):
    os.chdir(path)
    git_checkout(branch)
    git_reset()
    git_clean()
    git_pull()

# --------------------------------------------

def commit_message(path):
    os.chdir(path)
    git_repository = subprocess.run(
        ["git", "config", "--get", "remote.origin.url"], capture_output=True, text=True, check=True).stdout[:-5]

    git_revision = subprocess.run(
        ["git", "rev-parse", "HEAD"], capture_output=True, text=True, check=True).stdout[:-1]
    message = "* GIT commit from  {} branch {} revision {}".format(
        git_repository, os.environ["BUILD_BRANCH"], git_revision)
    return message

# --------------------------------------------

def git_tag():
    os.chdir(os.environ["BUILD_GIT_DIR"])
    version = get_version(SRC_GIT_DIR)
    print("version")
    if(check_tag_exist(str(version)) == True):
        print(Fore.RED + "The tag {} has already exist. Please check again the version in package.xml".format(str(version)))
        print(Style.RESET_ALL)
    subprocess.run(["git", "tag", "-a", str(version),
            "-m", get_message_log()], check=True)

    subprocess.run(["git", "push", "origin", "--tags"], check=True)

# --------------------------------------------


def main(argv=sys.argv[1:]):
    parser = argparse.ArgumentParser(description='Release and tag new version')
    parser.add_argument('-tag', action='store_true', help='tag new version')

    args = parser.parse_args(argv)

    git_pull_master(os.environ["BUILD_GIT_DIR"], os.environ["BUILD_BRANCH"])

    if args.tag:
        git_tag()


if __name__ == "__main__":
    ret = main()
    sys.exit(ret)
