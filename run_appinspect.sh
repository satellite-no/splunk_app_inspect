#!/bin/sh

# 
# run_splunk_appinspect.sh - Script to validate if Splunk TA/App fits in Splunk's policies.
# Copyright (C) 2020 Sean Elliott (Credit to Prabhas Gupte)
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# 

echo "Running Splunk AppInspect version $AppInspectVersion"
# Run App inspect
splunk-appinspect inspect /home/splunk_apps/target_app.tar.gz --mode precert --included-tags splunk_appinspect --included-tags cloud | tee /tmp/output.txt

# Count warnings produced
no_of_skipped=`awk -F ":" '/skipped/ {gsub(" ","");print $2}' /tmp/output.txt`
no_of_success=`awk -F ":" '/success/ {gsub(" ","");print $2}' /tmp/output.txt`
no_of_manual_check=`awk -F ":" '/manual_check/ {gsub(" ","");print $2}' /tmp/output.txt`
no_of_failure=`awk -F ":" '/failure/ {gsub(" ","");print $2}' /tmp/output.txt`
no_of_warning=`awk -F ":" '/warning/ {gsub(" ","");print $2}' /tmp/output.txt`
no_of_error=`awk -F ":" '/error/ {gsub(" ","");print $2}' /tmp/output.txt`
no_of_na=`awk -F ":" '/not_applicable/ {gsub(" ","");print $2}' /tmp/output.txt`

total_warn=`$no_of_failures + $no_of_errors`
exit_code=$((no_of_failures + no_of_errors))
exit $exit_code