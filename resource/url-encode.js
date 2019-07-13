/*
 *  This file is part of the DITA-OT Translate Plug-in project.
 *  See the accompanying LICENSE file for applicable licenses.
 */

//
//	Converts a value to lower case
//
//	@param  string -   The value to convert
//	@param  to -  The property to set
//

project.setProperty(
  attributes.get("to"),
  encodeURIComponent(attributes.get("string"))
);
