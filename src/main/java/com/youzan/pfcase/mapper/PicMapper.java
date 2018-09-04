package com.youzan.pfcase.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.youzan.pfcase.domain.Dapps;
import com.youzan.pfcase.domain.Picture;

@Repository
public interface PicMapper {
	
	List<Picture> getAllPics();
	List<Picture> getPics(Integer offset,Integer limit);
	List<Picture> getPicsTw(Integer offset,Integer limit);
	List<Picture> getPicsEn(Integer offset,Integer limit);
	List<Picture> getPicsKo(Integer offset,Integer limit);
	void imgUpdate(Picture pic);
	void imgUpdateEn(Picture pic);
	void imgUpdateTw(Picture pic);
	void imgUpdateKo(Picture pic);

}
