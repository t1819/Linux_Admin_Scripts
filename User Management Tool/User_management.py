import subprocess

# Helper function to run shell commands
def run_command(command):
    try:
        subprocess.run(command, check=True, shell=True)
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {e}")

# Function to add a new user and assign groups if specified
def add_user(username, groups=None):
    command = f"sudo useradd {username}"
    # Add user to groups if provided
    if groups:
        command += f" -G {','.join(groups)}"
    run_command(command)
    print(f"User {username} added successfully.")

# Function to remove a user and their home directory
def remove_user(username):
    command = f"sudo userdel -r {username}"
    run_command(command)
    print(f"User {username} removed successfully.")

# Function to update an existing user's username and/or groups
def update_user(username, new_username=None, groups=None):
    # Change the username if a new username is provided
    if new_username:
        command = f"sudo usermod -l {new_username} {username}"
        run_command(command)
        print(f"Username changed from {username} to {new_username}.")
    # Update the user's groups if provided
    if groups:
        command = f"sudo usermod -G {','.join(groups)} {username if not new_username else new_username}"
        run_command(command)
        print(f"Groups updated for {username if not new_username else new_username}.")

# Function to add an existing user to an existing group
def add_user_to_group(username, group):
    command = f"sudo usermod -aG {group} {username}"
    run_command(command)
    print(f"User {username} added to group {group}.")

# Function to set specific permissions on a directory for a user
def set_permissions(username, permissions, directory):
    command = f"sudo setfacl -m u:{username}:{permissions} {directory}"
    run_command(command)
    print(f"Permissions {permissions} set for {username} on {directory}.")

# Example usage
add_user('testuser', ['sudo', 'docker'])            # Add user 'testuser' to groups 'sudo' and 'docker'
remove_user('testuser')                             # Remove user 'testuser'
update_user('testuser', new_username='newuser', groups=['staff'])  # Change 'testuser' to 'newuser' and update groups
add_user_to_group('newuser', 'admin')               # Add 'newuser' to 'admin' group
set_permissions('newuser', 'rwx', '/home/newuser')  # Set 'rwx' permissions for 'newuser' on '/home/newuser'
