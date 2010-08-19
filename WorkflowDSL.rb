class WF_Step
  # Receive, Send, Condition, Execute, Stop
end
class WF_Receive < WF_Step
  def execute
    puts "Received Data"
  end
end
class WF_SendEmail < WF_Step
  def execute
    puts "Sent Email"
  end
end
class WF_Condition < WF_Step
  def execute
    puts "Condition evaluated"
  end
end
class WF_Else < WF_Step
  def execute
    puts "Else Condition evaluated"
  end
end
class WF_GoTo < WF_Step
  def execute
    puts "GoTo evaluated"
  end
end
class WF_Stop < WF_Step
  def execute
    puts "Stopped the workflow"
  end
end
class WF_Workflow
  attr_reader :wf_file_name, :this_step, :data, :workflow
  def initialize(wf_file_name)
    @wf_file_name = wf_file_name
    @data, @workflow = [], []
    @this_step = 0
  end
  def parse_workflow_definition
    puts "Parsing the workflow file: " + @wf_file_name
    f = File.new(@wf_file_name)
    workflow, data = [], []
    is_wf, is_data = false, false
    f.readlines.each do |line| 
      l = line.strip
      if l.length > 0 && l[0] != "#"
        if (l.split[0] == "Workflow:") 
          is_wf = true
        elsif (l.split[0] == "Data:") 
          is_data = true
        else
          if is_data
            @data << l
          else
            @workflow << l
          end
        end
      end
    end
  end
  
  def execute_this_step
    cls = "WF_" + workflow[@this_step].split[0]
    begin
      case cls
      when "WF_Receive"
        WF_Receive.new.execute
      when "WF_SendEmail"
        WF_SendEmail.new.execute
      when "WF_Condition"
        WF_Condition.new.execute
      when "WF_Else"
        WF_Else.new.execute
      when "WF_GoTo"
        WF_GoTo.new.execute
      when "WF_Stop"
        WF_Stop.new.execute
      else
        puts "Error Step: " + cls
      end
    rescue Exception => exc
        puts "RESCUED! " + exc.message
    end

    @this_step += 1
  end
end

#wf = WF_Workflow.new("BudgetRequest.wf")
wf = WF_Workflow.new("TravelRequest.wf")
wf.parse_workflow_definition
# puts "Data: " + wf.data.inspect
# puts "Workflow: " + wf.workflow.inspect
wf.workflow.each{|step| wf.execute_this_step}
