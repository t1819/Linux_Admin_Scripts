package main

import (
	"log"
	"os"
	"os/exec"
)

// updateSystem updates the OS and installed packages
func updateSystem() error {
	// Update the package list
	cmdUpdate := exec.Command("sudo", "apt-get", "update")
	cmdUpdate.Stdout = os.Stdout
	cmdUpdate.Stderr = os.Stderr
	if err := cmdUpdate.Run(); err != nil {
		return err
	}

	// Upgrade the packages
	cmdUpgrade := exec.Command("sudo", "apt-get", "-y", "upgrade")
	cmdUpgrade.Stdout = os.Stdout
	cmdUpgrade.Stderr = os.Stderr
	if err := cmdUpgrade.Run(); err != nil {
		return err
	}

	// Perform a distribution upgrade
	cmdDistUpgrade := exec.Command("sudo", "apt-get", "-y", "dist-upgrade")
	cmdDistUpgrade.Stdout = os.Stdout
	cmdDistUpgrade.Stderr = os.Stderr
	if err := cmdDistUpgrade.Run(); err != nil {
		return err
	}

	// Remove unnecessary packages
	cmdAutoremove := exec.Command("sudo", "apt-get", "-y", "autoremove")
	cmdAutoremove.Stdout = os.Stdout
	cmdAutoremove.Stderr = os.Stderr
	if err := cmdAutoremove.Run(); err != nil {
		return err
	}

	// Clean up
	cmdClean := exec.Command("sudo", "apt-get", "clean")
	cmdClean.Stdout = os.Stdout
	cmdClean.Stderr = os.Stderr
	if err := cmdClean.Run(); err != nil {
		return err
	}

	return nil
}

func main() {
	if err := updateSystem(); err != nil {
		log.Fatalf("Failed to update system: %v", err)
	}
	log.Println("System updated successfully.")
}
