package com.kedu.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.kedu.common.db.DBManager;
import com.kedu.member.dto.MemberDto;

public class MemberDao {
	
	private MemberDao() {
		
	}
	
	private static MemberDao instance = new MemberDao();
	
	public static MemberDao getInstance(){
		return instance;
	}

	public List<MemberDto> selectAll() {
		String sql = "select * from memberex order by no desc";
		
		List<MemberDto> list = new ArrayList<>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try{
			conn = DBManager.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				MemberDto mdto = new MemberDto();
				mdto.setNo(rs.getInt("no"));
				mdto.setMemnm(rs.getString("memnm"));
				mdto.setMememail(rs.getString("mememail"));
				mdto.setMempwd(rs.getString("mempwd"));
				list.add(mdto);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, stmt,rs);
		}
		return list;
	}

	public void insertMember(MemberDto mdto) {
		String sql = "insert into memberex values(	"
				   + " 	memberex_no_seq.nextval		"
				   + ", ?							"
				   + ", ?							"
				   + ", ?						   )";
		Connection conn = null;
		PreparedStatement  pstmt = null;
		
		try{
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mdto.getMemnm());
			pstmt.setString(2, mdto.getMememail());
			pstmt.setString(3, mdto.getMempwd());
			
			pstmt.executeUpdate();
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, pstmt);
		}
		
	}
	
	
	
	
}
