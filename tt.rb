require './WorkflowDSL'
#wf = WF_Workflow.new("BudgetRequest.wf")
#wf = WF_Workflow.new("TravelRequest.wf")
wf = WF_Workflow.new("CostItemPSR.wf")
wf.parse_workflow_definition
#puts "Workflow: " + wf.workflow.inspect
#puts "Data: " + wf.data.inspect
#puts "Service: " + wf.svc.inspect
wf.workflow.each{|step| wf.execute_this_step}
