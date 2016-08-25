package com.kedu.member.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kedu.common.action.Action;
import com.kedu.member.dao.MemberDao;
import com.kedu.member.dto.MemberDto;

public class MemberListAction implements Action {

	@Override
	public void execute(HttpServletRequest request
			, HttpServletResponse response) throws ServletException, IOException {
		String url = "/member/memberList.jsp";
		MemberDao bDao = MemberDao.getInstance();
		List<MemberDto> memberList = bDao.selectAll();
		request.setAttribute("memberList", memberList);
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
