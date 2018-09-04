package com.youzan.pfcase;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import com.youzan.pfcase.conf.SysProperties;

public class ApplicationBoot implements ApplicationListener<ContextRefreshedEvent>{
	
	private Logger log = LoggerFactory.getLogger(ApplicationBoot.class);
	
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if(event.getApplicationContext().getParent() == null){
			//root application context 没有parent，他就是老大.
			//需要执行的逻辑代码，当spring容器初始化完成后就会执行该方法。
			SysProperties.getInstance();
			log.error("boot up ");
		}
		
	}
}
