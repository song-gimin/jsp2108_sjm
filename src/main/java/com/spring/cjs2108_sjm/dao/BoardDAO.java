package com.spring.cjs2108_sjm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_sjm.vo.BoardReplyVO;
import com.spring.cjs2108_sjm.vo.BoardVO;

public interface BoardDAO {

	public int totRecCnt();

	public List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setBoardInput(@Param("vo") BoardVO vo);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public void addReadNum(@Param("idx") int idx);

	public List<BoardVO> getPreNext(@Param("idx") int idx);

	public void setBoardUpdate(@Param("vo") BoardVO vo);

	public void setBoardDelete(@Param("idx") int idx);

	public String maxLevelOrder(@Param("boardIdx") int boardIdx);

	public void setReplyInsert(@Param("rVo") BoardReplyVO rVo);

	public List<BoardReplyVO> getBoardReply(@Param("idx") int idx);

	public void levelOrderPlusUpdate(@Param("rVo") BoardReplyVO rVo);

	public void setReplyInsert2(@Param("rVo") BoardReplyVO rVo);

	public void setReplyDelete(@Param("replyIdx") int replyIdx);

}
