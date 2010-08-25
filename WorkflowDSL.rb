require 'require_all'
require_all 'Activities'

class WF_Workflow
  attr_reader :wf_file_name, :this_step
  attr_reader :data, :workflow, :svc
  def initialize(wf_file_name)
    @wf_file_name = wf_file_name
    @data, @workflow, @svc = [], [], []
    @this_step = 0
  end
  def execute_this_step
    cls = "WF_" + workflow[@this_step].split[0]
    begin
      step = Object.const_get(cls).new
      step.definition = workflow[@this_step]
      step.parse_definition
      step.execute
    rescue Exception => exc
        puts "Error: Define Activity #{cls}. " + exc.message
    end
    @this_step += 1
  end
  def parse_workflow_definition
    puts "Parsing the workflow file: " + @wf_file_name
    f = File.new(@wf_file_name)
    workflow, data = [], []
    is_wf, is_data, is_svc = false, false, false
    f.readlines.each do |line| 
      l = line.strip
      first_word = l.split[0]
      if l.length > 0 && l[0] != "#"
        if (first_word == "Workflow:") 
          is_wf = true
          is_data, is_svc = false, false
        elsif (first_word == "Data:") 
          is_data = true
          is_wf, is_svc = false, false
        elsif (first_word == "Service:") 
          is_svc = true
          is_wf, is_data = false, false
        else
          if is_data
            ar_data = l.split(',')
            @data += ar_data
          elsif is_wf
            @workflow << l
          elsif is_svc
            @svc << l
          end
        end
      end
      @data = @data.map{|d| d.strip.split.join('-')}
    end
  end
end
