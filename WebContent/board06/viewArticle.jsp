<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<head>
   <meta charset="UTF-8">
   <title>글보기</title>
   <style>
     #tr_btn_modify{
       display:none;
     }
   
   </style>
   <script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
   <script type="text/javascript" >
   
   //답글쓰기 버튼 클릭시 호출되는 함수로  
   //답글을 작성할수 있는 화면으로 이동시켜줘~라는 요청주소와
   //답글 작성시 부모글의 글번호를 매개변수로 전달 받는다.
    function fn_reply_form(url, parentNO){
	   	
	   console.log(parentNO);
	   
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var parentNOInput = document.createElement("input");
	     parentNOInput.setAttribute("type","hidden");
	     parentNOInput.setAttribute("name","parentNO");
	     parentNOInput.setAttribute("value", parentNO);
		 
	     form.appendChild(parentNOInput);
	     document.body.appendChild(form);
		 form.submit();
	 }
   
   
     function backToList(obj){
	    obj.action="${contextPath}/board/listArticles.do";
	    obj.submit();
     }
 
	 function fn_enable(obj){
		 document.getElementById("i_title").disabled=false;
		 document.getElementById("i_content").disabled=false;
		 document.getElementById("i_imageFileName").disabled=false;
		 document.getElementById("tr_btn_modify").style.display="block";
		 document.getElementById("tr_btn").style.display="none";
	 }
	 							
	 function fn_modify_article(obj){
		 obj.action="${contextPath}/board/modArticle.do";
		 obj.submit();
	 }
	 
	 //아래의 삭제하기 버튼을 클릭했을때 호출되는 함수 
	 function fn_remove_article(url,articleNO){		 

		 //DOM을 이용해 동적으로 <form>태그를 생성 합니다.
		 //<form></form>
		 var form = document.createElement("form");
		 //<form method="post" action="/board/removeArticle.do"></form>
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
// 		 <form action=url method="post"></form>
		 
		 //<input/>
	     var articleNOInput = document.createElement("input");
	     //<input type="hidden"/>
	     articleNOInput.setAttribute("type","hidden");
	     //<input type="hidden" name="articleNO"/>
	     articleNOInput.setAttribute("name","articleNO");
	     //<input type="hidden" name="articleNO" value="articleNO"/>
	     articleNOInput.setAttribute("value", articleNO);
	     
	     form.appendChild(articleNOInput);	     
// 	     <form action=url method="post">
// 	     	<input type="hidden" name="articleNO" value="articleNO"/>
// 	     </form>
	     
	     document.body.appendChild(form);	     
	//   <body>
	//	     <form action="/board/removeArticle.do" method="post">
	//	     	<input type="hidden" name="articleNO" value="articleNO"/>
	//	     </form>
	//   </body>
	     
		 form.submit(); //삭제요청 -> BoardController서블릿으로 
	 
	 }
	 
	 //수정할 이미지 파일을 다시 선택 했을때 미리 보기 이미지 보여 주는 곳
	 function readURL(input) {
	     if (input.files && input.files[0]) {
	         var reader = new FileReader();
	         reader.onload = function (e) {
	             $('#preview').attr('src', e.target.result);
	         }
	         reader.readAsDataURL(input.files[0]);
	     }
	 }  
 </script>
</head>
<body>
  <form name="frmArticle" method="post"  
        action="${contextPath}"  enctype="multipart/form-data">
  <table  border="0"  align="center">
  <tr>
   <td width="150" align="center" bgcolor="#FF9933">
      글번호
   </td>
   <td >
    <input type="text"  value="${article.articleNO }"  disabled />
    <%--글 수정시 글번호를 컨트롤러로 전송 하기 위해 미리 hidden태그를 이용해 글번호를 저장 합니다. --%>
    <input type="hidden" name="articleNO" value="${article.articleNO}"  />
   </td>
  </tr>
  <tr>
   <td width="150" align="center" bgcolor="#FF9933">
      작성자 아이디
   </td>
   <td >
    <input type=text value="${article.id }" name="writer"  disabled />
   </td>
  </tr>
  <tr>
   <td width="150" align="center" bgcolor="#FF9933">
      제목 
   </td>
   <td>
    <input type=text value="${article.title }"  name="title"  id="i_title" disabled />
   </td>   
  </tr>
  <tr>
   <td width="150" align="center" bgcolor="#FF9933">
      내용
   </td>
   <td>
    <textarea rows="20" cols="60"  name="content"  id="i_content"  disabled />
	${article.content }
	</textarea>
   </td>  
  </tr>
 
<c:if test="${not empty article.imageFileName && article.imageFileName!='null' }">  
<tr>
   <td width="150" align="center" bgcolor="#FF9933" rowspan="2">
      이미지
   </td>
   <td>
   	<%-- 이미지 수정에 대비해  미리 원래 이미지 파일 이름을 <hidden>태그에 저장합니다. --%>
     <input  type= "hidden"   name="originalFileName" value="${article.imageFileName }" />
    <img src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${article.imageFileName}" id="preview"/><br>
       
   </td>   
  </tr>  
  <tr>
    <td>
       <%-- 수정된 이미지 파일 이름을 전송 합니다. --%>
       <input  type="file"  name="imageFileName" 
	    id="i_imageFileName"   disabled   onchange="readURL(this);"   />
    </td>
  </tr>
 </c:if>
  <tr>
	   <td width=20% align=center bgcolor=#FF9933>
	      등록일자
	   </td>
	   <td>
	    <input type=text value="<fmt:formatDate value="${article.writeDate}" />" disabled />
	   </td>   
  </tr>
  <tr   id="tr_btn_modify"  >
	   <td colspan="2"   align="center" >
	   		<%--
	   			수정 반영하기 버튼을 클릭하면  함수를 호출시  <form>태그의 name속성값 frmArticle을 전달 하여
	   			<form>태그를 이용하여  BoardController서블릿으로 수정요청을 함
	   			수정요청 주소 :  /board/modArticle.do
	   		 --%>
	       <input type=button value="수정반영하기"   onClick="fn_modify_article(frmArticle)"  >
         <input type=button value="취소"  onClick="backToList(frmArticle)">
	   </td>   
  </tr>
    
  <tr  id="tr_btn"    >
   <td colspan=2 align=center>
	    <input type=button value="수정하기" onClick="fn_enable(this.form)">
	    
	   	<%-- 삭제하기 버튼을 클릭했을떄  fn_remove_article() 자바스크립트 함수를 호출하면서.. 
	   		 삭제 요청 주소값과 , 삭제할 글번호 articleNO를 전달 함.
	   	 --%>
	    <input type=button value="삭제하기" 
	    onClick="fn_remove_article('${contextPath}/board/removeArticle.do', ${article.articleNO})">
	    
	    
	    <input type=button value="리스트로 돌아가기"  
		onClick="backToList(this.form)">
		
		
	    <input type=button value="답글쓰기"  
		onClick="fn_reply_form('${contextPath}/board/replyForm.do', ${article.articleNO})">
		
		${article.articleNO}
		
   </td>
  </tr>
 </table>
 </form>
</body>
</html>




