<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<link rel="stylesheet" type="text/css"
	href="../../themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../../themes/icon.css" />
<link rel="stylesheet" type="text/css" href="../../css/global.css" />

<script type="text/javascript" src="../../js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../js/global.js"></script>

<script type="text/javascript">
	function add() {
		var addObjectForm = document.getElementById('addObjectForm');
		addObjectForm.action = "saveTask.action";
		addObjectForm.submit();
	}

	function cancel() {
		var addObjectForm = document.getElementById('addObjectForm');
		addObjectForm.action = "listTaskPage.action";
		addObjectForm.submit();
	}

	function checkRelatedObject() {
		var relatedObject = $('#relatedObject').children('option:selected')
				.val();
		if (relatedObject == 'Account') {
			$("span[id^='span']").css("display", "none");
			$('#spanAccount').css("display", "block");
		} else if (relatedObject == 'Case') {
			$("span[id^='span']").css("display", "none");
			$('#spanCase').css("display", "block");
		} else if (relatedObject == 'Contact') {
			$("span[id^='span']").css("display", "none");
			$('#spanContact').css("display", "block");
		} else if (relatedObject == 'Lead') {
			$("span[id^='span']").css("display", "none");
			$('#spanLead').css("display", "block");
		} else if (relatedObject == 'Opportunity') {
			$("span[id^='span']").css("display", "none");
			$('#spanOpportunity').css("display", "block");
		} else if (relatedObject == 'Target') {
			$("span[id^='span']").css("display", "none");
			$('#spanTarget').css("display", "block");
		} else if (relatedObject == 'Task') {
			$("span[id^='span']").css("display", "none");
			$('#spanTask').css("display", "block");
		}
	}

	$(document).ready(function() {
		$('#contactID').combogrid('setValue', '<s:property value="contactID"/>');
		$('#relatedAccountID').combogrid('setValue', '<s:property value="relatedAccountID"/>');
		$('#relatedCaseID').combogrid('setValue', '<s:property value="relatedCaseID"/>');
		$('#relatedContactID').combogrid('setValue', '<s:property value="relatedContactID"/>');
		$('#relatedLeadID').combogrid('setValue', '<s:property value="relatedLeadID"/>');
		$('#relatedOpportunityID').combogrid('setValue', '<s:property value="relatedOpportunityID"/>');
		$('#relatedTargetID').combogrid('setValue', '<s:property value="relatedTargetID"/>');
		$('#relatedTaskID').combogrid('setValue', '<s:property value="relatedTaskID"/>');			
		$('#assignedToID').combogrid('setValue', '<s:property value="assignedToID"/>');
		$('#startDate').datebox('setValue', '<s:property value="startDate"/>');
		$('#dueDate').datebox('setValue', '<s:property value="dueDate"/>');
		$('#relatedObject').change(function() {
			checkRelatedObject();
		});
		checkRelatedObject();
	})
</script>

</head>
<body>
	<div id="page-wrap">

		<s:include value="../header.jsp" />

		<s:include value="../menu.jsp" />

		<div id="feature">
			<div id="shortcuts" class="headerList">
				<span> <span style="white-space: nowrap;"> <a href="#"
						class="easyui-linkbutton" iconCls="icon-ok" onclick="add()"
						plain="true"><s:text name="button.save" /></a>
				</span> <span style="white-space: nowrap;"> <a href="#"
						class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()"
						plain="true"><s:text name="button.cancel" /></a>
				</span>
				</span>
			</div>

			<div id="feature-title">
				<s:if test="task!=null">
					<h2>
						<s:text name="title.updateTask" />
					</h2>
				</s:if>
				<s:else>
					<h2>
						<s:text name="title.createTask" />
					</h2>
				</s:else>
			</div>


			<div id="feature-content">
				<s:form id="addObjectForm" validate="true" namespace="/jsp/crm"
					method="post">
					<s:hidden name="task.id" value="%{task.id}" />
					<table style="" cellspacing="10" cellpadding="0" width="100%">
						<s:actionerror />
						<s:if test="hasFieldErrors()">
							<tr>
								<td align="left" colspan="4"><s:actionerror /> <s:iterator
										value="fieldErrors" status="st">
										<s:if test="#st.index  == 0">
											<s:iterator value="value">
												<font color="red"> <s:property escape="false" /></font>
											</s:iterator>
										</s:if>
									</s:iterator></td>
							</tr>
						</s:if>
					</table>

					<table style="padding: 10px;" cellspacing="10" cellpadding="0"
						width="100%">
						<tr>
							<td class="td-label"><label class="record-label"><s:text
										name="task.subject.label"></s:text>：</label></td>
							<td class="td-value"><input name="task.subject"
								class="easyui-validatebox record-value"
								data-options="required:true"
								value="<s:property value="task.subject" />" /></td>
							<td class="td-label"><label class="record-label"><s:text
										name="task.status.label"></s:text>：</label></td>
							<td class="td-value"><s:select name="statusID"
									list="statuses" listKey="id" listValue="name"
									cssClass="record-value" /></td>
						</tr>
					</table>

					<div class="easyui-tabs">
						<div title="<s:text name='tab.overview'/>" style="padding: 10px;">
							<table style="" cellspacing="10" cellpadding="0" width="100%">
								<tr>
									<td class="td-label"><label class="record-label"><s:text
												name="task.start_date.label"></s:text>：</label></td>
									<td class="td-value"><input id="startDate"
										name="startDate" type="text"
										class="easyui-datetimebox record-value" /></td>
									<td class="td-label"><label class="record-label"><s:text
												name="task.due_date.label"></s:text>：</label></td>
									<td class="td-value"><input id="dueDate" name="dueDate"
										type="text" class="easyui-datetimebox record-value" /></td>
								</tr>

								<tr>
									<td class="td-label"><label class="record-label"><s:text
												name="task.related_object.label"></s:text>：</label></td>
									<td class="td-value"><s:select name="task.related_object"
											id="relatedObject" cssClass="record-value"
											list="#{'Account':'Account','Case':'Case','Contact':'Contact','Lead':'Lead',
											'Opportunity':'Opportunity','Target':'Target','Task':'Task'}" />
									</td>
									<td class="td-label"><label class="record-label"><s:text
												name="task.related_record.label"></s:text>：</label></td>
									<td class="td-value">
									<span id="spanAccount"> 
									  <select
											id="relatedAccountID" class="easyui-combogrid record-value"
											name="relatedAccountID" style="width: 250px;"
											data-options="  
							            panelWidth:500,  
							            idField:'id',  
							            textField:'name',  
							            url:'listAccount.action',
							            fit: true,
							            mode:'remote',
							            columns:[[  
							                {field:'id',title:'<s:text name="entity.id.label" />',width:60},  
							                {field:'name',title:'<s:text name="entity.name.label" />',width:100},  
							                {field:'office_phone',title:'<s:text name="account.office_phone.label" />',width:120},  
							                {field:'email',title:'<s:text name="account.email.label" />',width:100},
							                {field:'assigned_to.name',title:'<s:text name="entity.assigned_to.label" />',width:100}  
							            ]]  
							        ">
										</select>
									</span> 
									<span id="spanCase"> 
									  <select id="relatedCaseID"
											class="easyui-combogrid record-value" name="relatedCaseID"
											style="width: 250px;"
											data-options="  
						            panelWidth:500,  
						            idField:'id',  
						            textField:'name',  
						            url:'listCase.action',
						            fit: true,
						            mode:'remote',
						            columns:[[  
						                {field:'id',title:'<s:text name="entity.id.label" />',width:60,align:'center',sortable:'true'},  
						                {field:'subject',title:'<s:text name="case.subject.label" />',width:100,align:'center',sortable:'true'},  
										{field:'account.name',title:'<s:text name="entity.account.label" />',width:80,align:'center',sortable:'true'},
										{field:'priority.name',title:'<s:text name="case.priority.label" />',width:80,align:'right',sortable:'true'},
										{field:'status.name',title:'<s:text name="case.status.label" />',width:80,align:'center',sortable:'true'},
										{field:'assigned_to.name',title:'<s:text name="entity.assigned_to.label" />',width:80,align:'center',sortable:'true'}
						            ]]  
						        ">
										</select>
									</span> 
									<span id="spanContact"> 
									  <select id="relatedContactID"
											class="easyui-combogrid record-value" name="relatedContactID"
											style="width: 250px;"
											data-options="  
						            panelWidth:500,  
						            idField:'id',  
						            textField:'name',  
						            url:'listContact.action',
						            fit: true,
						            mode:'remote',
						            columns:[[  
										{field:'id',title:'<s:text name="entity.id.label" />',width:80,align:'center',sortable:'true'},
										{field:'name',title:'<s:text name="entity.name.label" />',width:80,align:'center',sortable:'true'},
										{field:'title',title:'<s:text name="contact.title.label" />',width:80,align:'center',sortable:'true'},
										{field:'account.name',title:'<s:text name="entity.account.label" />',width:80,align:'right',sortable:'true'},
										{field:'email',title:'<s:text name="contact.email.label" />',width:80,align:'center',sortable:'true'},
										{field:'office_phone',title:'<s:text name="contact.office_phone.label" />',width:80,align:'center',sortable:'true'},
										{field:'assigned_to.name',title:'<s:text name="entity.assigned_to.label" />',width:80,align:'center',sortable:'true'}
						            ]]  
						        ">
										</select>
									</span>
									<span id="spanLead"> 
									  <select id="relatedLeadID"
											class="easyui-combogrid record-value" name="relatedLeadID"
											style="width: 250px;"
											data-options="  
						            panelWidth:500,  
						            idField:'id',  
						            textField:'name',  
						            url:'listLead.action',
						            fit: true,
						            mode:'remote',
						            columns:[[  
										{field:'id',title:'<s:text name="entity.id.label" />',width:80,align:'center',sortable:'true'},
										{field:'name',title:'<s:text name="entity.name.label" />',width:80,align:'center',sortable:'true'},
										{field:'title',title:'<s:text name="lead.title.label" />',width:80,align:'center',sortable:'true'},
										{field:'account.name',title:'<s:text name="entity.account.label" />',width:80,align:'right',sortable:'true'},
										{field:'office_phone',title:'<s:text name="lead.office_phone.label" />',width:80,align:'center',sortable:'true'},
										{field:'email',title:'<s:text name="lead.email.label" />',width:80,align:'center',sortable:'true'},
										{field:'assigned_to.name',title:'<s:text name="entity.assigned_to.label" />',width:80,align:'center',sortable:'true'}
						            ]]  
						        ">
										</select>
									</span>	
									</span>	
									<span id="spanOpportunity"> 
									  <select id="relatedOpportunityID"
											class="easyui-combogrid record-value" name="relatedOpportunityID"
											style="width: 250px;"
											data-options="  
						            panelWidth:500,  
						            idField:'id',  
						            textField:'name',  
						            url:'listOpportunity.action',
						            fit: true,
						            mode:'remote',
						            columns:[[  
			{field:'id',title:'<s:text name="entity.id.label" />',width:80,align:'center',sortable:'true'},
			{field:'name',title:'<s:text name="entity.name.label" />',width:80,align:'center',sortable:'true'},
			{field:'account.name',title:'<s:text name="entity.account.label" />',width:80,align:'center',sortable:'true'},
			{field:'sales_stage.name',title:'<s:text name="opportunity.salesStage.label" />',width:80,align:'right',sortable:'true'},
			{field:'opportunity_amount',title:'<s:text name="opportunity.opportunity_amount.label" />',width:80,align:'center',sortable:'true'},
			{field:'assigned_to.name',title:'<s:text name="entity.assigned_to.label" />',width:80,align:'center',sortable:'true'}
						            ]]  
						        ">
										</select>
									</span>	
									<span id="spanTarget"> 
									  <select id="relatedTargetID"
											class="easyui-combogrid record-value" name="relatedTargetID"
											style="width: 250px;"
											data-options="  
						            panelWidth:500,  
						            idField:'id',  
						            textField:'name',  
						            url:'listTarget.action',
						            fit: true,
						            mode:'remote',
						            columns:[[  
					{field:'id',title:'<s:text name="entity.id.label" />',width:80,align:'center',sortable:'true'},
					{field:'name',title:'<s:text name="entity.name.label" />',width:80,align:'center',sortable:'true'},
					{field:'title',title:'<s:text name="target.title.label" />',width:80,align:'center',sortable:'true'},
					{field:'account.name',title:'<s:text name="entity.account.label" />',width:80,align:'right',sortable:'true'},
					{field:'office_phone',title:'<s:text name="target.office_phone.label" />',width:80,align:'center',sortable:'true'},
					{field:'email',title:'<s:text name="target.email.label" />',width:80,align:'center',sortable:'true'},
					{field:'assigned_to.name',title:'<s:text name="entity.assigned_to.label" />',width:80,align:'center',sortable:'true'}
						            ]]  
						        ">
										</select>
									</span>										
									<span id="spanTask"> 
									  <select id="relatedTaskID"
											class="easyui-combogrid record-value" name="relatedTaskID"
											style="width: 250px;"
											data-options="  
						            panelWidth:500,  
						            idField:'id',  
						            textField:'name',  
						            url:'listTask.action',
						            fit: true,
						            mode:'remote',
						            columns:[[  
			{field:'id',title:'<s:text name="entity.id.label" />',width:80,align:'center',sortable:'true'},
			{field:'subject',title:'<s:text name="task.subject.label" />',width:80,align:'center',sortable:'true'},
			{field:'contact.name',title:'<s:text name="task.contact.label" />',width:80,align:'center',sortable:'true'},
			{field:'related_object',title:'<s:text name="task.related_object.label" />',width:80,align:'center',sortable:'true'},
			{field:'due_date',title:'<s:text name="task.due_date.label" />',width:80,align:'center',sortable:'true'},			
			{field:'assigned_to.name',title:'<s:text name="entity.assigned_to.label" />',width:80,align:'center',sortable:'true'}
						            ]]  
						        ">
										</select>
									</span>																																													
									</td>
								</tr>

								<tr>
									<td class="td-label"><label class="record-label"><s:text
												name="task.contact.label"></s:text>：</label></td>
									<td class="td-value"><select id="contactID"
										class="easyui-combogrid record-value" name="contactID"
										style="width: 250px;"
										data-options="  
						            panelWidth:500,  
						            idField:'id',  
						            textField:'name',  
						            url:'listContact.action',
						            fit: true,
						            mode:'remote',
						            columns:[[  
										{field:'id',title:'<s:text name="entity.id.label" />',width:80,align:'center',sortable:'true'},
										{field:'name',title:'<s:text name="entity.name.label" />',width:80,align:'center',sortable:'true'},
										{field:'title',title:'<s:text name="contact.title.label" />',width:80,align:'center',sortable:'true'},
										{field:'account.name',title:'<s:text name="entity.account.label" />',width:80,align:'right',sortable:'true'},
										{field:'email',title:'<s:text name="contact.email.label" />',width:80,align:'center',sortable:'true'},
										{field:'office_phone',title:'<s:text name="contact.office_phone.label" />',width:80,align:'center',sortable:'true'},
										{field:'assigned_to.name',title:'<s:text name="entity.assigned_to.label" />',width:80,align:'center',sortable:'true'}
						            ]]  
						        ">
									</select></td>
									<td class="td-label"><label class="record-label"><s:text
												name="task.priority.label"></s:text>：</label></td>
									<td class="td-value"><s:select name="priorityID"
											list="priorities" listKey="id" listValue="name"
											cssClass="record-value" /></td>									
								</tr>

								<tr>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.assigned_to.label"></s:text>：</label></td>
									<td class="td-value" colspan="3"><select id="assignedToID"
										class="easyui-combogrid record-value" name="assignedToID"
										style="width: 250px;"
										data-options="  
							            panelWidth:500,  
							            idField:'id',  
							            textField:'name',  
							            url:'/grass/jsp/system/listUser.action',
							            fit: true,
							            mode:'remote',
							            columns:[[  
							                {field:'id',title:'<s:text name="entity.id.label" />',width:60},  
							                {field:'name',title:'<s:text name="entity.name.label" />',width:100},  
							                {field:'title',title:'<s:text name="user.title.label" />',width:120},  
							                {field:'department',title:'<s:text name="user.department.label" />',width:100},
							                {field:'status.name',title:'<s:text name="user.status.label" />',width:100} 
							            ]]  
							        ">
									</select></td>
									<td class="td-label"></td>
									<td class="td-value"></td>									
								</tr>
							</table>
						</div>

						<div title="<s:text name='tab.details'/>" style="padding: 10px;">
							<table style="" cellspacing="10" cellpadding="0" width="100%">
								<tr>
									<td class="td-label" valign="top"><label
										class="record-label"><s:text
												name="entity.description.label"></s:text>：</label></td>
									<td class="td-value" valign="top"><s:textarea
											name="task.description" rows="20" cssStyle="width:500px;"
											cssClass="record-value" /></td>
									<td class="td-label"></td>
									<td class="td-value"></td>
								</tr>
								<tr>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.createdBy.label"></s:text>：</label></td>
									<td class="td-value"><label class="record-value"><s:property
												value="createdBy" /></label></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.createdOn.label"></s:text>：</label></td>
									<td class="td-value"><label class="record-value"><s:property
												value="createdOn" /></label></td>
								</tr>
								<tr>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.updatedBy.label"></s:text>：</label></td>
									<td class="td-value"><label class="record-value"><s:property
												value="updatedBy" /></label></td>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.updatedOn.label"></s:text>：</label></td>
									<td class="td-value"><label class="record-value"><s:property
												value="updatedOn" /></label></td>
								</tr>
								<tr>
									<td class="td-label"><label class="record-label"><s:text
												name="entity.id.label"></s:text>：</label></td>
									<td class="td-value"><label class="record-value"><s:property
												value="id" /></label></td>
									<td class="td-label"></td>
									<td class="td-value"></td>
								</tr>
							</table>
						</div>

					</div>
				</s:form>
			</div>
		</div>

		<s:include value="../footer.jsp" />

	</div>
</body>
</html>



