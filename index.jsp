<%@page import="com.cht.emap.webservice.sdk.FeatureService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.cht.emap.webservice.sdk.FeatureService"%>
<%@ page import="net.hinet.map.wfs.FeatureService.FS_Feature_Result"%>
<%@ page import="net.hinet.map.wfs.FeatureService.Feature"%>
<%@ page import="cht.paas.util.CloudLogger" %>
<%@ page import="cht.paas.util.LogLevel" %>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONValue"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GeoWeb Feature</title>
</head>
<body>
<%
CloudLogger logger = CloudLogger.getLogger();
logger.setLevel(LogLevel.ALL);

String isv = "367f7deaa1ce47b185a0c91cb6d8f714";
String isvkey="n+ABj+1w6e1Ht2A2ziBh0Q==";
FeatureService featureService = null;
FS_Feature_Result featureResult = null;

try{
	featureService = new FeatureService(isv, isvkey, "http", "api.hicloud.hinet.net", 80);
	//out.println("start3.1<br>"+featureService.isCloudAlive());
	//out.println("start3.2<br>"+featureService.isServiceAlive());
}catch(Exception e){
	logger.error("error");
	out.println("error");
}

try{
	final int MAX=10;
	String defaultKeyword = "台北市  火鍋";
	out.println("Top "+MAX+" results of searching [<b>"+defaultKeyword+"</b>]:<br>");
    //依照參數進行圖徵定位
    featureResult = featureService.SmartRefinedQuery(defaultKeyword);
    if (featureResult.getInformation().getCode() > 0)
    {
    	Feature[] featureList = featureResult.getFeatureList();
    	int i=1;
    	out.println("<tbody><table  border=\"1\">");
    	out.println("<tr><td>編號</td><td>名稱</td><td>縣市</td><td>鄉鎮</td></tr>");
    	for(Feature feature: featureList){
	        String name = feature.getSysName();
	        String county = feature.getCounty();
	        String town = feature.getTown();
	        out.println("<tr><td>"+i+"</td><td>"+name+"</td><td>"+county+"</td><td>"+town+"</td></tr>");
	        //out.println("["+i+"] "+name+",\t "+county+",\t "+town+"<br>");
	        if(i>=MAX)
	        	break;
	        else
	        	i++;
    	}
    	out.println("</tbody></table>");
    	
    }
}catch (Exception e){
    // 本元件功能異常
    out.println(e.getMessage());
}

%>

<form method="POST" action="feature.jsp">
<p>請輸入關鍵字:<input type="text" name="keyword" size="50" value="高雄市 車站"></p>
<p><input type="submit" value="送出" name="B1"></p>
</form>

</body>
</html>