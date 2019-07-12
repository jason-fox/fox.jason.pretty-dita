/*
 *  This file is part of the DITA-OT Pretty DITA Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

// This function outputs a colorized success message.

var escapeCode = String.fromCharCode(27);
var colorize = "true".equals(project.getProperty("cli.color"));
var input = "[SUCCESS] DITA files have been formatted";
var ansiColor = "[32m";

if (colorize) {
  input = escapeCode + ansiColor + input;
  input += escapeCode + "[0m";
}

project.log("", 1);
project.log(input, 1);
