/*
 *  This file is part of the DITA-OT Pretty DITA Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

package fox.jason.prettydita.tasks;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;

// This function outputs a colorized success message.

public class SuccessEchoTask extends Task {

  /**
   * Creates a new <code>SuccessEchoTask</code> instance.
   */
  public SuccessEchoTask() {
    super();
  }

  /**
   * Method execute.
   *
   * @throws BuildException if something goes wrong
   */
  @Override
  public void execute() {
    String escapeCode = Character.toString((char) 27);
    boolean colorize = "true".equals(getProject().getProperty("cli.color"));
    String input = "[SUCCESS] DITA files have been formatted";

    if (colorize) {
      input = escapeCode + "[32m" + input;
      input += escapeCode + "[0m";
    }

    getProject().log("", 1);
    getProject().log(input, 1);
  }
}
