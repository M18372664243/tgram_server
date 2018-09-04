CREATE DATABASE `pfcase` DEFAULT CHARACTER SET utf8;
use `pfcase`;



create table signon (
    username varchar(25) not null,
    password varchar(25)  not null,
    constraint pk_signon primary key (username)
);

create table account (
    userid varchar(25) not null,
    email varchar(80) not null,
    role varchar(10) not null,
    constraint pk_account primary key (userid)
);

create table caselist (
    caseid int not null auto_increment,
    casename varchar(50) not null comment '用例名称',
    belongmodulea varchar(25) not null comment '所属一级功能模块名',
    belongmoduleb varchar(25) not null comment '所属二级功能模块名',
    belongmodulec varchar(25) not null comment '所属三级功能模块名',
    priority TINYINT not null comment '用例等级',
    casestep TEXT not null comment '用例步骤',
    reviewed TINYINT not null DEFAULT 0 comment '已评审?',
    automated TINYINT not null DEFAULT 0 comment '已自动化?',
    deleted TINYINT not null DEFAULT 0 comment '已删除?',
    creator varchar(25) not null comment '创建人',
    modifier varchar(25) not null comment '修改人',
    createtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updatetime TIMESTAMP NOT NULL  COMMENT '更新时间',

    constraint pk_caseid primary key (caseid),
    key `idx_belongmodule` (`belongmodulea`, `belongmoduleb`, `belongmodulec`),
    key `idx_priority` (`priority`)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='用例表';

create table task (
    taskid int not null auto_increment,
    taskname varchar(25) not null comment '任务名称',
    prepared TINYINT not null DEFAULT 0 comment '用例已分配?',
    owner varchar(25) not null comment '任务执行人',
    taskdone TINYINT not null DEFAULT 0 comment '全部用例已执行完成?(auto generated)',
    taskscore TINYINT not null DEFAULT 0 comment '任务执行质量平均分(auto generated)',
    deleted TINYINT not null DEFAULT 0 comment '已删除?',
    creator varchar(25) not null comment '创建人',
    modifier varchar(25) not null comment '修改人',
    createtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updatetime TIMESTAMP NOT NULL  COMMENT '更新时间',

    constraint pk_taskid primary key (taskid),
    key `idx_owner` (`owner`),
    key `idx_taskdone` (`taskdone`)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='任务表';

create table taskcase (
    taskid int not null default 0 comment '任务id',
    caseid int not null comment '用例id',
    casedone TINYINT not null DEFAULT 0 comment '某用例已执行完成?',
    evaluated TINYINT not null DEFAULT 0 comment '某用例已评分?',
    casescore TINYINT not null DEFAULT 0 comment '用例执行质量评分',
    bugurl varchar(255) not null DEFAULT '' comment 'Bug URL',

    constraint pk_taskidcaseid primary key (taskid, caseid),
    key `idx_taskid`(`taskid`),
    key `idx_taskid_casescore`(`taskid`, `casescore`)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='任务用例关系表';

create table rank (
    rankid int not null auto_increment,
    taskname varchar(25) not null comment '任务名称',
    owner varchar(25) not null comment '任务执行人',
    score TINYINT not null DEFAULT 0 comment '评分',
    reason TEXT not null comment '评分理由',

    constraint pk_rankid primary key (rankid),
    key `idx_owner`(`owner`),
    key `idx_owner_score`(`owner`, `score`)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='积分排行表';

create table groups (
    groupid int not null auto_increment,
    groupname varchar(80) not null comment '群组名称',
    grouplink varchar(200) not null comment '群组链接',
    groupicon varchar(200) not null comment '群组图像链接',
    enabled TINYINT not null DEFAULT 0 comment '是否有效',
    seq TINYINT not null DEFAULT 0 comment '序列',
    deleted TINYINT not null DEFAULT 0 comment '已删除?',
    createtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updatetime TIMESTAMP NOT NULL  COMMENT '更新时间',
    
    constraint pk_groupid primary key (groupid)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='群列表';
create table groups_tw as select * from groups;
create table groups_en as select * from groups;
create table groups_ko as select * from groups;
create table dapps (
    dappid int not null auto_increment,
    dappname varchar(80) not null comment 'dapp名称',
    dapplink varchar(200) not null comment 'dapp链接',
    dappicon varchar(200) not null comment 'dapp图像链接',
    enabled TINYINT not null DEFAULT 0 comment '是否有效',
    seq TINYINT not null DEFAULT 0 comment '序列',
    deleted TINYINT not null DEFAULT 0 comment '已删除?',
    dapptype TINYINT not null DEFAULT 0 comment '类型',
    createtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updatetime TIMESTAMP NOT NULL  COMMENT '更新时间', 
    constraint pk_dappid primary key (dappid)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='dapp列表';
create table dapps_tw as select * from dapps;
create table dapps_en as select * from dapps;
create table dapps_ko as select * from dapps;
create table dapps_wechat (
    dappid int not null auto_increment,
    dappname varchar(80) not null comment 'dapp名称',
    dapplink varchar(200) not null comment 'dapp链接',
    dappicon varchar(200) not null comment 'dapp图像链接',
    enabled TINYINT not null DEFAULT 0 comment '是否有效',
    seq TINYINT not null DEFAULT 0 comment '序列',
    deleted TINYINT not null DEFAULT 0 comment '已删除?',
    dapptype TINYINT not null DEFAULT 0 comment '类型',
    dappgroup TINYINT not null DEFAULT 1 comment '分组',
    createtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updatetime TIMESTAMP NOT NULL  COMMENT '更新时间',
    constraint pk_dappid primary key (dappid)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='dapp_wechat列表';
create table dapps_wechat_tw as select * from dapps_wechat;
create table dapps_wechat_en as select * from dapps_wechat;
create table dapps_wechat_ko as select * from dapps_wechat;
alter table dapps add dapptype TINYINT not null DEFAULT 0 comment '类型';

create table picture (
    id int not null auto_increment,
    name varchar(80) default null comment '图片名称',
    link varchar(200) default null comment '图片跳转链接',
    linktype tinyint not null default 0 comment '0：无跳转；1：内部链接；2：外部链接；3：群链接',
    icon varchar(200) not null comment '图片地址',
    seq TINYINT not null DEFAULT 0 comment '序列',
    createtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updatetime TIMESTAMP NOT NULL  COMMENT '更新时间',
    primary key (id)
)ENGINE=INNODB DEFAULT CHARSET=utf8;

create table picture_tw as select * from picture;
create table picture_en as select * from picture;
create table picture_ko as select * from picture;

create table recommend (
    recommendid int not null auto_increment,
    recommendname varchar(80) not null comment 'recommend名称',
    recommendlink varchar(200) not null comment 'recommend链接',
    recommendicon varchar(200) not null comment 'recommend图像链接',
    enabled TINYINT not null DEFAULT 0 comment '是否有效',
    seq TINYINT not null DEFAULT 0 comment '序列',
    deleted TINYINT not null DEFAULT 0 comment '已删除?',
    createtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updatetime TIMESTAMP NOT NULL  COMMENT '更新时间',
    
    constraint pk_dappid primary key (recommendid)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='drecommend列表';


insert into dapps values(1,'创世神犬','http://h5.ibeechat.com/webview/crypto-dog','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/pets_dog/pet_dog_0.png',1,1,0,0,now(),now());
insert into dapps values(2,'幸运转盘','http://h5.ibeechat.com/webview/lottery','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_02lottery_dapps3x.png ',1,1,0,1,now(),now());
insert into dapps values(3,'限时领Bee','http://h5.ibeechat.com/webview/spread','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_01beepoints_dapps_3x.png',1,1,0,0,now(),now());
insert into dapps values(4,'英雄社区','http://bitbird.org/webview_beechat/native_hero_community','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_04hero_dapps_3x.png',1,1,0,0,now(),now());
insert into dapps values(5,'区块链指数','http://bitbird.org/webview_beechat/blockchainindexes','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_03index_dapps3x.png',1,1,0,0,now(),now());
insert into dapps values(6,'短线助手','http://bitbird.org/webview_beechat/assistant','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_06assistant_dapps3x.png',1,1,0,0,now(),now());
insert into dapps values(7,'智能配仓','http://bitbird.org/webview_beechat/smartplan','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_04combination_dapps3x.png',1,1,0,0,now(),now());
insert into dapps values(8,'加仓点','http://bitbird.org/webview_beechat/buyprice','http://beechat-web-cn.oss-cn-qingdao.aliyuncs.com/static/res/images/dapp/ic_05warehouse_dapps3x.png',1,1,0,now(),now());

insert into dapps values(3,'行情','','http://xs.athena.pub/images/dapps/hangqing.png',1,1,0,now(),now(),3);
insert into dapps values(3,'资讯','https://ssr.biyong.io/flashNew/flash','http://xs.athena.pub/images/dapps/dapp_news.png',1,1,0,now(),now(),0);
insert into dapps values(4,'项目周报','https://ssr.biyong.io/weekly/channel/','http://xs.athena.pub/images/dapps/dapp_weekreport.png',1,1,0,now(),now(),0);
insert into dapps values(5,'官方网站','http://ana.pub/','http://xs.athena.pub/images/dapps/dapp_officialweb.png',1,1,0,now(),now(),0);
insert into dapps values(6,'火星财经','http://a.app.qq.com/o/simple.jsp?pkgname=com.linekong.mars24','http://xs.athena.pub/images/dapps/dapp_hxcj.png',1,1,0,now(),now(),0);
insert into dapps values(7,'火星部落','http://a.app.qq.com/o/simple.jsp?pkgname=com.mars.marscommunity','http://xs.athena.pub/images/dapps/dapp_hxbl.png',1,1,0,now(),now(),0);
insert into dapps values(8,'火星基地','http://a.app.qq.com/o/simple.jsp?pkgname=com.mars.marsstation','http://xs.athena.pub/images/dapps/dapp_hxjd.png',1,1,0,now(),now(),0);
insert into dapps values(9,'帮助与公告','','http://xs.athena.pub/images/dapps/dapp_help.png',1,1,0,now(),now(),2);

insert into dapps_wechat values(1,'邀请奖励','https://eos.ana.pub/i','http://xs.athena.pub/images/dapps_wechat/dapp_wechat_invite.png',1,1,0,0,1,now(),now());
insert into dapps_wechat values(2,'标注人脉','','http://xs.athena.pub/images/dapps_wechat/dapp_wechat_tag.png',1,1,0,1,2,now(),now());
insert into dapps_wechat values(3,'资讯','https://www.zhoubao.me/flashNew/flash','http://xs.athena.pub/images/dapps_wechat/dapp_wechat_news.png',1,1,0,0,2,now(),now());
insert into dapps_wechat values(4,'热门群组','https://m.ana.pub/webview/hot-group/#/','http://xs.athena.pub/images/dapps_wechat/dapp_wechat_hotgroup.png',1,1,0,0,3,now(),now());
insert into dapps_wechat values(5,'项目周报','https://www.zhoubao.me/flashNew/weekly','http://xs.athena.pub/images/dapps_wechat/dapp_wechat_weekreport.png',1,1,0,0,3,now(),now());
insert into dapps_wechat values(6,'官方网站','http://ana.pub/','http://xs.athena.pub/images/dapps_wechat/dapp_wechat_officialweb.png',1,1,0,0,4,now(),now());
insert into dapps_wechat values(7,'帮助与公告','','http://xs.athena.pub/images/dapps_wechat/dapp_wechat_help.png',1,1,0,2,4,now(),now());
insert into dapps_wechat values(8,'火星财经','http://a.app.qq.com/o/simple.jsp?pkgname=com.linekong.mars24','http://xs.athena.pub/images/dapps_wechat/dapp_wechat_hxcj.png',1,1,0,0,5,now(),now());
insert into dapps_wechat values(9,'火星部落','http://a.app.qq.com/o/simple.jsp?pkgname=com.mars.marscommunity','http://xs.athena.pub/images/dapps_wechat/dapp_wechat_hxbl.png',1,1,0,0,5,now(),now());
insert into dapps_wechat values(10,'火星基地','http://a.app.qq.com/o/simple.jsp?pkgname=com.mars.marsstation','http://xs.athena.pub/images/dapps_wechat/dapp_wechat_hxjd.png',1,1,0,0,6,now(),now());

insert into recommend values(1,'推荐群','https://download.iibeechat.com/tgram_web','https://download.iibeechat.com/gram/images/find/ic_recommend_social@3x.png',1,1,0,now(),now());
insert into recommend values(2,'行情','http://sosobtc.me/soso/kline_list','https://download.iibeechat.com/gram/images/find/ic_quotes_social@3x.png',1,1,0,now(),now());
insert into recommend values(3,'GRAM Sugars','http://beechat.io','https://download.iibeechat.com/gram/images/find/ic_dapps_social@3x.png',1,1,0,now(),now());
insert into recommend values(4,'DAPP','DAPP','https://download.iibeechat.com/gram/images/find/ic_dapps_social@3x.png',1,1,0,now(),now());

insert into groups values(1,'1','2','3',1,1,0,now(),now());
insert into groups values(2,'1','2','3',1,1,0,now(),now());

INSERT INTO signon VALUES('admin','Your Password');
INSERT INTO account VALUES('admin','Your E-mail address','admin');


insert into caselist values(1,'1','2','3','4',5,'6',1,1,1,'1','2',now(),now());
insert into caselist values(2,'1','2','3','4',5,'6',1,1,1,'1','2',now(),now());

create table user (
   id bigint not null primary key auto_increment comment '主键id',
   name varchar(64) not null comment '登陆名',
   salt varchar(64) not null comment '用户的盐',
   password_md5 varchar(64) not null comment '登陆密码',
   created bigint not null comment '用户创建时间',
   updated bigint not null comment '用户更新时间',
   key (name)
) DEFAULT CHARSET=utf8mb4 comment '用户';

