/*
 *  This file is part of the DITA-OT Translate Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

//	Iterator function to run a given macro against a set of files
//
//	@param macro - A macro to run.
//	@param fileset - A set of files
//	@param dir - The input directory
//	@param todir - The output directory

var filesets = elements.get("fileset");
var macro = attributes.get("macro");
var dir = attributes.get("dir");
var todir = attributes.get("todir");

for (var i = 0; i < filesets.size(); ++i) {
  var fileset = filesets.get(i);
  var scanner = fileset.getDirectoryScanner(project);
  scanner.scan();
  var files = scanner.getIncludedFiles();
  for (var j = 0; j < files.length; j++) {
    var task = project.createTask(macro);
    if (files[i] !== "") {
      try {
        task.setDynamicAttribute("file", dir + "/" + files[j]);
        task.setDynamicAttribute("todir", todir);
        task.execute();
      } catch (err) {
        task.log("Execution error: " + err.message);
      }
    }
  }
}
