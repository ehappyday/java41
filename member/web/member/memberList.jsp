<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Dialog - Modal form</title>
  <link rel="stylesheet" href="../css/jquery-ui.min.css">
  <style>
  	* {font-size: 12px}
    label, input { display:block; }
    input.text { margin-bottom:12px; width:95%; padding: .4em; }
    fieldset { padding:0; border:0; margin-top:25px; }
    h1 { font-size: 1.2em; margin: .6em 0; }
    div#users-contain { width: 350px; margin: 20px 0; }
    div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
    div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; font-size: 12px }
  </style>
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="../js/jquery-ui.min.js"></script>
  <script>
  $( function() {
    var dialog, form,
 
      // From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
      emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
      name = $( "#name" ),
      email = $( "#email" ),
      password = $( "#password" ),
      allFields = $( [] ).add( name ).add( email ).add( password ),
      tips = $( ".validateTips" );
 
    function updateTips( t ) {
      tips
      	.text( t )
      	.addClass( "ui-state-highlight" );
      setTimeout(function() {
        tips.removeClass( "ui-state-highlight", 1500 );
      }, 500 );
    }
 
    function checkLength( o, n, min, max ) {
      if ( o.val().length > max || o.val().length < min ) {
        o.addClass( "ui-state-error" );
        updateTips( n + "은(는) " + min + "에서 " + max + "자까지 입력해 주세요." );
        return false;
      } else {
        return true;
      }
    }
 
    function checkRegexp( o, regexp, n ) {
      if ( !( regexp.test( o.val() ) ) ) {
        o.addClass( "ui-state-error" );
        updateTips( n );
        return false;
      } else {
        return true;
      }
    }
 
    function addUser() {
      var valid = true;
      allFields.removeClass( "ui-state-error" );
 
      valid = valid && checkLength( name, "이름", 3, 16 );
      valid = valid && checkLength( email, "이메일", 6, 80 );
      valid = valid && checkLength( password, "비밀번호", 5, 16 );
 
      valid = valid && checkRegexp( name, /^[가-힣a-z]([가-힣0-9a-z_\s])+$/i, "성명은 3자에서 16자 이내로 작성해 주세요" );
      valid = valid && checkRegexp( email, emailRegex, "eg. ui@jquery.com" );
      valid = valid && checkRegexp( password, /^([0-9a-zA-Z])+$/, "Password는 영문자 소문자, 숫자 5~16 허용합니다. : a-z 0-9" );
 
      if ( valid ) {
        $("#frm").submit();
        dialog.dialog( "close" );
      }
      return valid;
    }
 
    dialog = $( "#dialog-form" ).dialog({
      autoOpen: false,
      height: 350,
      width: 280,
      modal: true,
      buttons: {
        "회원등록": addUser,
        "취소": function() {
          dialog.dialog( "close" );
        }
      },
      close: function() {
        form[ 0 ].reset();
        allFields.removeClass( "ui-state-error" );
        tips
        	.text("모든 필드에 입력해 주세요")
        	.removeClass( "ui-state-highlight");
      }
    });
 
   /*  form = dialog.find( "form" ).on( "submit", function( event ) {
      event.preventDefault();
      addUser();
    }); */
 
    $( "#create-user" ).button().on( "click", function() {
      dialog.dialog( "open" );
    });
  } );
  </script>
</head>
<body>
 
<div id="dialog-form" title="회원등록">
  <p class="validateTips">모든 필드에 입력해 주세요</p>
 
  <form name="frm" id="frm" action="/MemberServlet" method="post">
  	<input type="hidden" name="command" value="member_insert">
    <fieldset>
      <label for="name">이름</label>
      <input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" placeholder="성명 입력">
      <label for="email">이메일</label>
      <input type="text" name="email" id="email" placeholder="이메일 입력" class="text ui-widget-content ui-corner-all">
      <label for="password">비밀번호</label>
      <input type="password" name="password" id="password" placeholder="비밀번호 입력" class="text ui-widget-content ui-corner-all">
 
      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    </fieldset>
  </form>
</div>
 
 
<div id="users-contain" class="ui-widget">
  <h1>회원 현황</h1>
  <table id="users" class="ui-widget ui-widget-content">
    <thead>
      <tr class="ui-widget-header ">
        <th>이름</th>
        <th>이메일</th>
        <th>비밀번호</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${memberList }" var="member">
	      <tr>
	        <td>${member.memnm }</td>
	        <td>${member.mememail }</td>
	        <td>${member.mempwd }</td>
	      </tr>
      </c:forEach>	
    </tbody>
  </table>
</div>
<button id="create-user">회원등록</button>
 
 
</body>
</html>