package main

import (
	"bytes"
	"fmt"
	"os/exec"
	"time"
	"io/ioutil"
)

func runCommand(cmd string, args []string) (string, error) {
	var out bytes.Buffer
	var stderr bytes.Buffer
	command := exec.Command(cmd, args...)
	command.Stdout = &out
	command.Stderr = &stderr
	err := command.Run()
	if err != nil {
		return "", fmt.Errorf("%v: %v", err, stderr.String())
	}
	return out.String(), nil
}

func runLynis() string {
	output, err := runCommand("lynis", []string{"audit", "system"})
	if err != nil {
		return fmt.Sprintf("Error running Lynis: %v", err)
	}
	return output
}

func runOSSEC() string {
	// Adjust the command and arguments according to your OSSEC configuration
	output, err := runCommand("ossec-control", []string{"status"})
	if err != nil {
		return fmt.Sprintf("Error running OSSEC: %v", err)
	}
	return output
}

func generateReport(lynisOutput, ossecOutput string) string {
	report := fmt.Sprintf(
		"Security Scan Report - %v\n\nLynis Output:\n%v\n\nOSSEC Output:\n%v\n",
		time.Now().Format(time.RFC1123),
		lynisOutput,
		ossecOutput,
	)
	return report
}

func main() {
	lynisOutput := runLynis()
	ossecOutput := runOSSEC()

	report := generateReport(lynisOutput, ossecOutput)

	// Save the report to a file
	err := ioutil.WriteFile("security_scan_report.txt", []byte(report), 0644)
	if err != nil {
		fmt.Printf("Error writing report to file: %v", err)
	} else {
		fmt.Println("Security scan report generated successfully.")
	}
}
