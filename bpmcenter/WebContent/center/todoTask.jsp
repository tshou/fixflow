<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>待办任务</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/global.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<style>
a{text-decoration: none;}

.red_star{
   color:red;
}
.pagearea{
   margin-top:20px;
   float:right;
   text-align:right; 
   width:100%;
   font-size:12px;
   
}
.pagearea .qp{
   border:#AAAADD solid 1px;
   width:60px;
   height:10px;
   margin-right:3px;
   margin-left:3px;
   text-align:center;
}
.pagearea .disqp{
   border:#EEEEEE solid 1px;
   width:60px;
   height:10px;
   margin-right:3px;
   margin-left:3px;
   color:#EEEEEE;
}
.pagearea a {
   border:#AAAADD solid 1px;
   width:25px;
   height:10px;
   margin-right:3px;
   margin-left:3px;
   text-align:center;
}
.pagearea .point{
   width:25px;
   height:10px;
   margin-right:3px;
   margin-left:3px;
}
.pagearea .focuspage{
  border:#FD6D01 solid 1px;
  background-color:#FFEDE1;
  color:#FD6D01;
  width:25px;
  height:10px;
  margin-right:3px;
  margin-left:3px;
  font-weight:bold;
  text-align:center;
}
.pagearea info{
  color:#666666;
}
.pagearea a{
  TEXT-DECORATION:none;
  color:#3366CC;
}
</style>
<script type="text/javascript">
/*  
 * "userId" 用户编号
 * "pdkey" 流程编号
 * "pageIndex" 第几页
 * "rowNum" 有几行
 * "agentUserId" 有几行
 * "agentType" 0我代理别人，1别人委托给我
 * "title" 查询主题
 * "processVeriy" 查询变量
 * "arrivalTimeS" 到达时间开始
 * "arrivalTimeE" 到达时间结束
 * "initor" 发起人
 * @param @return
 * "dataList" 数据列表
 * "pageNumber" 总行数
 * "agentUsers" 代理用户
 * "agentToUsers" 委托用户
 * "pageIndex" 第几页
 * "rowNum" 有几行
 */
$(function(){
  var agentType = $("input[name=agentType]").val();
  var userId = $("input[name=userId]").val();
  $("a[name=myTask]").click(function(){
    $("#agentUserId").val();
    $("#agentType").val();
    $("#subForm").submit();
  });
  $("a[name=agentUsers]").click(function(){
    var userId = $(this).attr("userId");
    $("#agentUserId").val(userId);
    $("#agentType").val('1');
    $("#subForm").submit();
  });
  $("a[name=agentToUsers]").click(function(){
    var userId = $(this).attr("userId");
    $("#agentUserId").val(userId);
    $("#agentType").val('0');
    $("#subForm").submit();
  });
  $("a[name=flowGraph]").click(function(){
    var pdk = $(this).attr("pdk");
    var pii = $(this).attr("pii");
    var obj = {};
    window.showModalDialog("FlowCenter?action=getTaskDetailInfo&processDefinitionKey="+pdk+"&processInstanceId="+pii,obj,"dialogWidth=800px;dialogHeight=600px");
  });
  $("a[name=doTask]").click(function(){
    var tii = $(this).attr("tii");
    var pdk = $(this).attr("pdk");
    var pii = $(this).attr("pii");
    var bizKey = $(this).attr("bk");
    
    var obj = {};
    window.showModalDialog("FlowCenter?action=doTask&taskId="+tii+"&processInstanceId="+pii+"&bizKey="+bizKey+"&processDefinitionKey="+pdk,obj,"dialogWidth=800px;dialogHeight=600px");
  });
});
</script>

</head>

<body>
<div class="main-panel">
<jsp:include page="top.jsp" flush="true"/>

<div class="center-panel">
<form id="subForm" method="post" action="FlowCenter">
<!-- 左 -->
	<div class="left">
    	<div class="left-nav-box">
        	<div class="left-nav"><a name="myTask" href="#">我的待办任务</a></div>
            <div class="left-nav-orange-line">&nbsp;</div>
            


       	  <div class="left-nav m-top"><h1>代理人</h1></div>
       	  	<c:if test="${result.agentUsers!= null && fn:length(result.agentUsers) != 0}">
			    <c:forEach items="${result.agentUsers}" var="agentUsers" varStatus="index">
			      <div class="left-nav-orange-line">&nbsp;</div>
			      <div class="left-nav"><a name="agentUsers" userId="${agentUsers.id}" href="#"><img src="images/temp/user01.jpg" />${agentUsers.name}</a></div>
			    </c:forEach>
       	  	</c:if>

       	  <div class="left-nav m-top"><h1>委托人</h1></div>
       	  	<c:if test="${result.agentToUsers!= null && fn:length(result.agentToUsers) != 0}">
			    <c:forEach items="${result.agentToUsers}" var="agentToUsers" varStatus="index">
			      <div class="left-nav-orange-line">&nbsp;</div>
			      <div class="left-nav"><a name="agentToUsers" userId="${agentToUsers.id}" href="#"><img src="images/temp/user01.jpg" />${agentToUsers.name}</a></div>
			    </c:forEach>
       	  	</c:if>
        </div>
        <div class="message">
        	<div class="title"><a href="#"><em class="icon-message"></em>消息中心</a></div>
        	<div class="message-content">
            	<div class="msg"><img src="images/temp/user01.jpg" />张飞：今天还没吃午饭！<div class="time">一小时前</div></div>
             	<div class="msg"><img src="images/temp/user01.jpg" />曹操：煮酒论英雄！谁一起吃饭啊<div class="time">一小时前</div></div>
            	<div class="msg"><img src="images/temp/user01.jpg" />张飞：今天还没吃午饭！<div class="time">一小时前</div></div>
            	<div class="msg"><img src="images/temp/user01.jpg" />张飞：今天还没吃午饭！<div class="time">一小时前</div></div>
            	<div class="msg"><img src="images/temp/user01.jpg" />张飞：今天还没吃午饭！<div class="time">一小时前</div></div>
       	</div>
        </div> 
    </div>
    <div class="right">
    <!-- 隐藏参数部分 -->
		<input type="hidden" name="agentUserId" value="<c:out value="${result.agentUserId}"/>">
		<input type="hidden" name="agentType" value="<c:out value="${result.agentType}"/>">
    	<input type="hidden" name="action" value="getMyTask"/> 
    	<div class="search">
        	<table width="100%">
              <tr>
                <td class="title-r">任务主题：</td>
                <td><input type="text" id="text_0" name="title" class="fix-input" style="width:160px;" value="${result.title}"/></td>
                <td class="title-r">流程变量：</td>
                <td><input type="text" id="text_1" name="text_1" class="fix-input" style="width:160px;" value=""/></td>
                <td class="title-r">单 据 号：</td>
                <td><input type="text" id="text_2" name="bizKey" class="fix-input" style="width:160px;" value="${result.bizKey}"/></td>
              </tr>
              <tr>
                <td class="title-r">发 起 人：</td>
                <td><input type="text" id="text_3" name="initor" class="fix-input" style="width:160px;" value="${result.initor}"/></td>
                <td class="title-r">到达时间：</td>
                <td><input type="text" id="text_4" name="arrivalTimeS" class="fix-input" style="width:69px;" value="${result.arrivalTimeS}"/>
                 - <input type="text" id="text_5" name="arrivalTimeE" class="fix-input" style="width:69px;" value="${result.arrivalTimeE}"/></td>
                <td>&nbsp;</td>
                <td><input type="submit"/></td>
              </tr>
            </table>
        </div>
        <div class="content">
        	<table width="100%" class="fix-table">
              <thead>
                <th width="30">&nbsp;</th>
                <th width="70">发起人</th>
                <th>任务</th>
                <th width="300">单据号</th>
                <th width="180">发起/到达时间</th>
                <th width="60">流程状态</th>
              </thead>
		    <c:forEach items="${result.dataList}" var="dataList" varStatus="index">
		    <tr>
		      <td><c:out value="${index.index+1}"/></td>
		      <td><img src="${dataList.icon}" height="30" width="30" alt="头像"><br>${dataList.userName}</td>
		      <td>
		   		<div><span>流&nbsp;程：</span><span>${dataList.nodeName}&nbsp; --&nbsp; ${dataList.processDefinitionName}</span></div>
		   		<div><span>主&nbsp;题：</span><span><a name="doTask" href="#" tii="${dataList.taskInstanceId}" pii="${dataList.processInstanceId}" bk="${dataList.bizKey}" pdk="${dataList.processDefinitionKey}">${dataList.description}</a></span></div>   
		    	</td>
		      <td>${dataList.bizKey}</td>
		      <td>
		      	<div>
					发起时间:<fmt:formatDate value="${dataList.PI_START_TIME}" type="both"/> 
				</div>
				<div>
		      		到达时间:<fmt:formatDate value="${dataList.createTime}" type="both"/>
		      	</div>
		      	</td>
		      <td><a name="flowGraph" href="#" pii="${dataList.processInstanceId}" pdk="${dataList.processDefinitionKey}">查看</a></td>
		    </tr>
		    </c:forEach>
            </table>

        </div>
    </div>
<!-- 分页 -->	    
	    <div id="page">
	      <jsp:include page="page.jsp" flush="true"/>
	    </div>

	</form>
</div>
</div>
 
</body>
</html>