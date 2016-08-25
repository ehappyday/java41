package com.kedu.member.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kedu.common.action.Action;
import com.kedu.member.dao.MemberDao;
import com.kedu.member.dto.MemberDto;

public class MemberInsertAction implements Action {

	@Override
	public void execute(HttpServletRequest request
			, HttpServletResponse response) throws ServletException, IOException {
		MemberDto mdto = new MemberDto();

		mdto.setMemnm(request.getParameter("name"));
		mdto.setMememail(request.getParameter("email"));
		mdto.setMempwd(request.getParameter("password"));
		System.out.println(mdto);
		MemberDao mdao = MemberDao.getInstance();
		mdao.insertMember(mdto);
		
		new MemberListAction().execute(request, response);
	}

}
