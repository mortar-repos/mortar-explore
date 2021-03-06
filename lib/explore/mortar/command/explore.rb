#
# Copyright 2014 Mortar Data Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "explore/mortar/local/controller"
require "mortar/command/base"

# explore the results of mortar recsys
class Mortar::Command::Explore < Mortar::Command::Base


  # explore RECSYS_RESULTS 
  #
  # View the results of your pig job.  Specify the directory where
  # the part files of the pig job exist
  #
  # -t, --port PORT  # What port mortar explore should run on.
  # -r, --recsys     # Option to render a details page that is 
  #                  # specific for the recommendation engine 
  #                  # results.  If your project is forked from 
  #                  # mortar-recsys, the default will always 
  #                  # render in this mode and you do not need 
  #                  # to pass this option
  #
  # Examples:
  #
  #        $ mortar explore data/out/item-item 
  def index
    results_data  = shift_argument
    unless results_data 
      error("Usage: mortar explore OUTPUT_DIRECTORY\nMust specify DIRECTORY.")
    end
    validate_arguments!
    ctrl = Mortar::Local::Controller.new
  

    defaults = load_defaults('DEFAULTS')
    if defaults == nil
      defaults = {:recsys => nil}
    end

    ctrl.explore(results_data, options[:port], defaults[:recsys] || options[:recsys])
  end


end
