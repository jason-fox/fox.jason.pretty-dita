/*
 *  This file is part of the DITA-OT Pretty DITA Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

//
//    Iterator function to run a given macro against a set of files
//
//    @param toDir - The output location of the files
//    @param dir  - The location of the files to process
//    @param macro - A macro to run.
//    @param fileset - A set of files

var dir = attributes.get("dir");
var toDir = attributes.get("todir");
var filesets = elements.get("fileset");
var macro = attributes.get("macro");

for (var i = 0; i < filesets.size(); ++i) {
  var fileset = filesets.get(i);
  var scanner = fileset.getDirectoryScanner(project);
  scanner.scan();
  var files = scanner.getIncludedFiles();
  for (var j = 0; j < files.length; j++) {
    var task = project.createTask(macro);
    if (files[i] !== "") {
      try {
        task.setDynamicAttribute("src", files[j]);
        task.setDynamicAttribute("dir", dir);
        task.setDynamicAttribute("toDir", toDir);
        task.execute();
      } catch (err) {
        task.log("Execution error: " + err.message);
      }
    }
  }
}
