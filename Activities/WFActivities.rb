class WF_Step
  # Receive, Send, Condition, Execute, Stop
  attr_accessor :definition
  attr_accessor :activity, :group, :form, :label
  attr_accessor :email_group, :email_template
  def parse_definition
    temp = definition.split.map{|s| s if s.downcase != s}
    params = temp.join(' ').split
    @activity = params[0]
    params
  end
end
class WF_ReceiveData < WF_Step
  def parse_definition
    # Receive data from Employee through CostItemPSRForm
    params = super
    @group, @form = params[1], params[2]
    #puts "Activity: #{@activity}, Group: #{@group}, Form: #{@form}"
  end
  def execute
    puts "Received Data from the group #{@group} via the form #{@form}"
  end
end
class WF_SendEmail < WF_Step
  def parse_definition
    # SendEmail to FinancialGroupEmail using FinancialGroupTemplate label Step-2
    params = super
    @email_group, @email_template = params[1], params[2]
    #puts "Activity: #{@activity}, Email Group: #{@email_group}, Email Template: #{@email_template}"
  end
  def execute
    puts "Sent Email to the group #{@email_group} using the template #{@email_template}"
  end
end
class WF_If < WF_Step
  def parse_definition
  end
  def execute
    puts "Condition evaluated"
  end
end
class WF_End < WF_Step
  def parse_definition
  end
  def execute
    puts "End of Condition evaluated"
  end
end
class WF_Else < WF_Step
  def parse_definition
  end
  def execute
    puts "Else Condition evaluated"
  end
end
class WF_GoTo < WF_Step
  def parse_definition
  end
  def execute
    puts "GoTo evaluated"
  end
end
class WF_Stop < WF_Step
  def parse_definition
  end
  def execute
    puts "Stopped the workflow"
  end
end