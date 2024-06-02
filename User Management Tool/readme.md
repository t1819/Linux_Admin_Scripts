# User Management Script

This Python script provides a set of command-line utilities to manage user accounts on a Unix-based system. The script leverages shell commands to add, remove, update users, manage group memberships, and set directory permissions.

## Prerequisites

- Python 3.x
- `subprocess` module (comes with Python standard library)
- Root or sudo privileges to execute user management commands

## Functions

### `run_command(command)`

- **Description**: A helper function to execute shell commands.
- **Parameters**:
  - `command` (str): The shell command to run.

### `add_user(username, groups=None)`

- **Description**: Adds a new user and assigns groups if specified.
- **Parameters**:
  - `username` (str): The username to be added.
  - `groups` (list, optional): A list of groups to assign to the user.

### `remove_user(username)`

- **Description**: Removes a user and their home directory.
- **Parameters**:
  - `username` (str): The username to be removed.

### `update_user(username, new_username=None, groups=None)`

- **Description**: Updates an existing user's username and/or groups.
- **Parameters**:
  - `username` (str): The current username.
  - `new_username` (str, optional): The new username to change to.
  - `groups` (list, optional): A list of groups to assign to the user.

### `add_user_to_group(username, group)`

- **Description**: Adds an existing user to a specific group.
- **Parameters**:
  - `username` (str): The username to add to the group.
  - `group` (str): The group to add the user to.

### `set_permissions(username, permissions, directory)`

- **Description**: Sets specific permissions on a directory for a user.
- **Parameters**:
  - `username` (str): The username to set permissions for.
  - `permissions` (str): The permissions to set (e.g., 'rwx').
  - `directory` (str): The directory to set permissions on.

## Example Usage

```python
# Add user 'testuser' to groups 'sudo' and 'docker'
add_user('testuser', ['sudo', 'docker'])

# Remove user 'testuser'
remove_user('testuser')

# Change 'testuser' to 'newuser' and update groups
update_user('testuser', new_username='newuser', groups=['staff'])

# Add 'newuser' to 'admin' group
add_user_to_group('newuser', 'admin')

# Set 'rwx' permissions for 'newuser' on '/home/newuser'
set_permissions('newuser', 'rwx', '/home/newuser')
```

## Notes

- Ensure you have the necessary permissions to execute these commands, generally requiring root or sudo access.
- This script is designed for Unix-based systems (Linux, macOS).
- Adjust user/group names and directory paths as per your system setup before running the script.

## License

This project is licensed under the MIT License.

## Contact

For any inquiries or support, please contact [Your Name] at [Your Email].

---

For any inquiries or support, please contact [Your Name] at [Your Email].

## Contributions

Contributions are welcome! If you have suggestions for improvements or find bugs, please open an issue or submit a pull request on the repository.

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a pull request.

## Disclaimer

- Use this script at your own risk. Always test in a safe environment before deploying to production systems.
- Incorrect usage may lead to unintended changes to system users and permissions.

---

Thank you for using the User Management Script!
