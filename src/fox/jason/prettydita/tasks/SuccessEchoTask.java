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

  private boolean getUseColor() {
    final String os = System.getProperty("os.name");
    if (os != null && os.startsWith("Windows")) {
      return false;
    } else if (System.getenv("NO_COLOR") != null) {
      return false;
    } else if ("dumb".equals(System.getenv("TERM"))) {
      return false;
    } else if (System.console() == null) {
      return false;
    }
    return !"false".equals(getProject().getProperty("cli.color"));
  }

  /**
   * Method execute.
   *
   * @throws BuildException if something goes wrong
   */
  @Override
  public void execute() {
    String escapeCode = Character.toString((char) 27);
    String input = "[SUCCESS] DITA files have been formatted";

    if (getUseColor()) {
      input = escapeCode + "[32m" + input;
      input += escapeCode + "[0m";
    }

    getProject().log("", 1);
    getProject().log(input, 1);
  }
}
