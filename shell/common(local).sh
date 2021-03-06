#! /bin/bash

# common.sh
# Defining variables and functions. Referenced by /usr/bin/dep_*
# Modify by shidg 20180420 16:00

#source ~/.bashrc

function UNALIAS_CP {
	if alias cp >/dev/null 2>&1;then
		unalias cp
	fi
}

function NEW_COMMIT() {
    git fetch
    git log HEAD...origin/$1 --oneline > /tmp/commit.info
    if [ -s /tmp/commit.info ];then
        return 0
    else
        return 1
    fi
}

function GET_CODE_VERSION {
    git log | head -2> /tmp/gitinfo
    git diff HEAD HEAD~ --stat >> /tmp/gitinfo
    export GIT_MSG=`cat /tmp/gitinfo`
    export COMMIT_VERSION=`head -1 /tmp/gitinfo | cut -d " " -f 2`
    export COMMIT_AUTHOR=`head -2 /tmp/gitinfo |tail -1 | cut -d ":" -f 2`
    export DEPLOY_VERSION=`echo ${COMMIT_VERSION:0:5}`
}

function ERRTRAP(){ 
    echo "[LINE :$1 ] Error: Command or functions exited with status $?"
    exit
}

function EXIT_CONFIRMATION() {
    echo -ne "Code not updated, continue?[Y/N]"
	read -n 1 answer
	case $answer in
	    Y|y)
		echo
		echo "The script will continue..."
        sleep 1
		;;
		N|n)
		echo
		echo "The script is about to exit..."
        sleep 1
        exit
		;;
		*)
		echo
		EXIT_CONFIRMATION
		;;
	esac
}


function DELETE_PROFILES() {
    cd ${MANAGE_SOURCE_DIR}

	# consumer-app
	for i in apollo-env config fastdfs-client ftpconfig jedis
	do
    	rm -f consumer-app/src/main/resources/$i.properties
	done

	for i in log4j applicationContext-dubbo-consumer
	do
    	rm -f consumer-app/src/main/resources/$i.xml
	done

	# manage-orders
	for i in acp_sdk apollo-env config dubbo ftpconfig jdbc jedis msgConfig refund securityConfig serverconfig spy 
	do
    	rm -f manage-orders/src/main/resources/$i.properties
	done

	for i in log4j applicationContext-dubbo-consumer
	do
    	rm -f manage-orders/src/main/resources/$i.xml
	done

	# report-superviser
	for i in config gbReportConfig msgConfig serverconfig tcpConfig
	do
    	rm -f report-superviser/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	rm -f report-superviser/src/main/resources/$i.xml
	done

	# manage-web
	for i in apollo-env config fastdfs-client ftpconfig jedis 
	do
    	rm -f manage-web/src/main/resources/$i.properties
	done

	for i in log4j applicationContext-dubbo-consumer
	do
    	rm -f manage-web/src/main/resources/$i.xml
	done

	# manage-metadata
	for i in apollo-env dubbo ftpconfig jdbc jedis msgConfig securityConfig serverconfig sms
	do
    	rm -f manage-metadata/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	rm -f manage-metadata/src/main/resources/$i.xml
	done

	# manage-datawarehouse
	#for i in jedis msgConfig serverconfig
	#do
    #	rm -f manage-datawarehouse/src/main/resources/$i.properties
	#done

	#for i in log4j hbase-site
	#do
    #	rm -f manage-datawarehouse/src/main/resources/$i.xml
	#done

	# wechat
	for i in acp_sdk config jedis
	do
    	rm -f wechat/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	rm -f wechat/src/main/resources/$i.xml
	done

	# manage-app
	for i in config jedis
	do
    	rm -f manage-app/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	rm -f manage-app/src/main/resources/$i.xml
	done

	# manage-report
	for i in acp_sdk apollo-env config  ftpconfig jdbc jedis msgConfig securityConfig serverconfig spy
	do
    	rm -f manage-report/src/main/resources/$i.properties
	done

	for i in log4j applicationContext-dubbo-consumer
	do
    	rm -f manage-report/src/main/resources/$i.xml
	done

	# manage-thirdparty
	for i in config dubbo ftpconfig jdbc securityConfig serverconfig
	do
    	rm -f manage-thirdparty/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	rm -f manage-thirdparty/src/main/resources/$i.xml
	done

    # download
	for i in server
	do
    	rm -f download/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	rm -f download/src/main/resources/$i.xml
	done

	# consumer-wap
	for i in config jedis
	do
    	rm -f consumer-wap/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	rm -f consumer-wap/src/main/resources/$i.xml
	done

}

function GENERATE_PROFILES() {
    trap 'ERRTRAP $LINENO' ERR
    UNALIAS_CP

	# 生成配置文件
	cd ${MANAGE_SOURCE_DIR}
    # consumer-app
	for i in apollo-env config fastdfs-client ftpconfig jedis
	do
    	cp -f consumer-app/src/main/resources/$i.properties.template consumer-app/src/main/resources/$i.properties
        dos2unix consumer-app/src/main/resources/$i.properties
	done

	for i in log4j applicationContext-dubbo-consumer
	do
    	cp -f consumer-app/src/main/resources/$i.xml.template consumer-app/src/main/resources/$i.xml
        dos2unix consumer-app/src/main/resources/$i.xml
	done

	# manage-orders
	for i in acp_sdk apollo-env config dubbo ftpconfig jdbc jedis msgConfig refund securityConfig serverconfig spy
	do
    	cp -f manage-orders/src/main/resources/$i.properties.template manage-orders/src/main/resources/$i.properties
        dos2unix manage-orders/src/main/resources/$i.properties
	done

	for i in log4j applicationContext-dubbo-consumer
	do
    	cp -f manage-orders/src/main/resources/$i.xml.template  manage-orders/src/main/resources/$i.xml
        dos2unix manage-orders/src/main/resources/$i.xml
	done

	# report-superviser
	for i in config gbReportConfig msgConfig serverconfig tcpConfig
	do
    	cp -f report-superviser/src/main/resources/$i.properties.template report-superviser/src/main/resources/$i.properties
        dos2unix report-superviser/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	cp -f report-superviser/src/main/resources/$i.xml.template report-superviser/src/main/resources/$i.xml
        dos2unix report-superviser/src/main/resources/$i.xml
	done	
	
	# manage-web
	for i in apollo-env config fastdfs-client ftpconfig jedis 
	do
    	cp -f manage-web/src/main/resources/$i.properties.template manage-web/src/main/resources/$i.properties
        dos2unix manage-web/src/main/resources/$i.properties
	done

	for i in log4j applicationContext-dubbo-consumer
	do
    	cp -f manage-web/src/main/resources/$i.xml.template manage-web/src/main/resources/$i.xml
        dos2unix manage-web/src/main/resources/$i.xml
	done

	# manage-metadata
	for i in apollo-env dubbo ftpconfig jdbc jedis msgConfig securityConfig serverconfig sms
	do
    	cp -f manage-metadata/src/main/resources/$i.properties.template manage-metadata/src/main/resources/$i.properties
        dos2unix manage-metadata/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	cp -f manage-metadata/src/main/resources/$i.xml.template  manage-metadata/src/main/resources/$i.xml
        dos2unix manage-metadata/src/main/resources/$i.xml
	done

	# manage-datawarehouse
	#for i in jedis msgConfig serverconfig
	#do
    #	cp -f manage-datawarehouse/src/main/resources/$i.properties.template manage-datawarehouse/src/main/resources/$i.properties
    #    dos2unix manage-datawarehouse/src/main/resources/$i.properties
	#done

	#for i in log4j hbase-site
	#do
    #	cp -f manage-datawarehouse/src/main/resources/$i.xml.template manage-datawarehouse/src/main/resources/$i.xml
    #    dos2unix manage-datawarehouse/src/main/resources/$i.xml
	#done

	# wechat
	for i in acp_sdk config jedis
	do
    	cp -f wechat/src/main/resources/$i.properties.template wechat/src/main/resources/$i.properties
        dos2unix wechat/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	cp -f wechat/src/main/resources/$i.xml.template wechat/src/main/resources/$i.xml
        dos2unix wechat/src/main/resources/$i.xml
	done

	# manage-app
	for i in config jedis
	do
    	cp -f manage-app/src/main/resources/$i.properties.template manage-app/src/main/resources/$i.properties
        dos2unix manage-app/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	cp -f manage-app/src/main/resources/$i.xml.template manage-app/src/main/resources/$i.xml
        dos2unix manage-app/src/main/resources/$i.xml
	done

	# manage-report
	for i in acp_sdk apollo-env config  ftpconfig jdbc jedis msgConfig securityConfig serverconfig spy
	do
    	cp -f manage-report/src/main/resources/$i.properties.template manage-report/src/main/resources/$i.properties
        dos2unix manage-report/src/main/resources/$i.properties
	done

	for i in log4j applicationContext-dubbo-consumer
	do
    	cp -f manage-report/src/main/resources/$i.xml.template manage-report/src/main/resources/$i.xml
        dos2unix manage-report/src/main/resources/$i.xml
	done

	# manage-thirdparty
	for i in config dubbo ftpconfig jdbc securityConfig serverconfig
	do
    	cp -f manage-thirdparty/src/main/resources/$i.properties.template manage-thirdparty/src/main/resources/$i.properties
        dos2unix manage-thirdparty/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	cp -f manage-thirdparty/src/main/resources/$i.xml.template manage-thirdparty/src/main/resources/$i.xml
        dos2unix manage-thirdparty/src/main/resources/$i.xml
	done

    # download
	for i in server
	do
    	cp -f download/src/main/resources/$i.properties.template download/src/main/resources/$i.properties
        dos2unix download/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	cp -f download/src/main/resources/$i.xml.template download/src/main/resources/$i.xml
        dos2unix download/src/main/resources/$i.xml
	done

    # log4j.xml
    # no change

	# consumer-wap
	for i in config jedis
	do
    	cp -f consumer-wap/src/main/resources/$i.properties.template consumer-wap/src/main/resources/$i.properties
        dos2unix consumer-wap/src/main/resources/$i.properties
	done

	for i in log4j
	do
    	cp -f consumer-wap/src/main/resources/$i.xml.template consumer-wap/src/main/resources/$i.xml
        dos2unix consumer-wap/src/main/resources/$i.xml
	done
}

function MODIFY_PROFILES() {
    trap 'ERRTRAP $LINENO' ERR

	# 修改配置文件
	cd ${MANAGE_SOURCE_DIR}
    ### consumer-app ###
	# apollo-env.properties 
    sed -i "/^server.env/ s/=.*/=uat/" consumer-app/src/main/resources/apollo-env.properties
    sed -i "/^uat.meta/ s/=.*/=http:\/\/meta.apollo.uat.feezu.cn:8582/" consumer-app/src/main/resources/apollo-env.properties
    sed -i "/^apollo.cluster/ s/=.*/=prep/" consumer-app/src/main/resources/apollo-env.properties

    # config.properties
    sed -i "/^METADATA_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8020\/metadata\/services/" consumer-app/src/main/resources/config.properties
    sed -i "/^REPORT_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8040\/report\/services/" consumer-app/src/main/resources/config.properties
    sed -i "/^ORDER_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8010\/orders\/services/" consumer-app/src/main/resources/config.properties
    #sed -i "/^WECHAT_PAY_AVAILABLE_COM_CODE/ s/=.*/=YWX00001,DZ00002/" consumer-app/src/main/resources/config.properties
    #sed -i "/^NEED_UPDATE_COMPANY_CODE/ s/=.*/=YWX00001,DZ00001,QZBJX001/" consumer-app/src/main/resources/config.properties
    #sed -i "/^EXCEPT_UPDATE_COMPANY_CODE/ s/=.*/=DZ00002/" consumer-app/src/main/resources/config.properties
    sed -i "/^qrcode_url/ s/=.*/=https:\/\/appprep.feezu.cn/" consumer-app/src/main/resources/config.properties
    sed -i "/^FAST_DNF_URL/ s/=.*/=http:\/\/img.feezu.cn/" consumer-app/src/main/resources/config.properties
    sed -i "/^RUN_ENVIRONMENT/ s/=.*/=prod/" consumer-app/src/main/resources/config.properties

    # fastdfs-client.properties
    sed -i "/^fastdfs.tracker_servers/ s/= .*/= 10.44.183.203:22122/" consumer-app/src/main/resources/fastdfs-client.properties
    
    # ftpconfig.properties
    sed -i "/^img.ftp.host/ s/=.*/=imgprep.feezu.cn/" consumer-app/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxIdle/ s/=.*/=50/" consumer-app/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxActive/ s/=.*/=50/" consumer-app/src/main/resources/ftpconfig.properties
    sed -i "/^img.http.host/ s/=.*/=imgprep.feezu.cn/" consumer-app/src/main/resources/ftpconfig.properties

    # jedis.properties
    sed -i "/^redis.host/ s/=.*/=redis_01/" consumer-app/src/main/resources/jedis.properties
    sed -i "/^redis.port/ s/=.*/=6379/" consumer-app/src/main/resources/jedis.properties
    sed -i "/^redis.timeout/ s/=.*/=8000/" consumer-app/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxIdle/ s/=.*/=200/" consumer-app/src/main/resources/jedis.properties
    sed -i "/^redis.pool.minIdle/ s/=.*/=30/" consumer-app/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxActive/ s/=.*/=2000/" consumer-app/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxWait/ s/=.*/=2000/" consumer-app/src/main/resources/jedis.properties

    # log4j.xml
    sed -i '/<appender-ref ref="elkfile"\/>/d' consumer-app/src/main/resources/log4j.xml
    # sed -i "" consumer-app/src/main/resources/log4j.xml
    # applicationContext-dubbo-consumer.xml
    sed -i '/dubbo:registry address/ s/=.*/="zookeeper:\/\/10.172.164.152:2181"\/>/' consumer-app/src/main/resources/applicationContext-dubbo-consumer.xml

	### manage-orders ###
    # acp_sdk.properties
    sed -i "/^create_backURL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/unionpay\/callback/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^finish_backURL/ s/=.*/=https:\/\/111.200.241.178\/manage\/orderpayment\/notify4finishOrder/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^create_renew_backURL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/unionpay\/callbackRenew/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^refund_backURL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/unionpay\/refundCallback/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^EPPS_NOTIFY_URL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/epps\/notify/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^EPPS_RETURN_URL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/epps\/epps_return/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^EPPS_REFUND_NOTIFY_URL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/epps\/refundNotify/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^ALI_NOTIFY_URL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/ali\/notifyByAlipay/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^ALI_RECHARGE_NOTIFY_URL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/ali\/rechargeCallback/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^ALI_RETURN_URL/ s/=.*/=https:\/\/mprep.feezu.cn\/paycallback/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^WECHAT_NOTIFY_URL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/wechat\/payCallback/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^WECHAT_RECHARGE_NOTIFY_URL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/wechat\/rechargeCallback/" manage-orders/src/main/resources/acp_sdk.properties
    sed -i "/^WECHAT_RETURN_URL/ s/=.*/=https:\/\/mprep.feezu.cn\/paycallback/" manage-orders/src/main/resources/acp_sdk.properties

    # apollo-env.properties
    sed -i "/^server.env/ s/=.*/=uat/" manage-orders/src/main/resources/apollo-env.properties
    sed -i "/^uat.meta/ s/=.*/=http:\/\/meta.apollo.uat.feezu.cn:8582/" manage-orders/src/main/resources/apollo-env.properties
    sed -i "/^apollo.cluster/ s/=.*/=prep/" manage-orders/src/main/resources/apollo-env.properties

    # config.properties
    sed -i "/^METADATA_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8020\/metadata\/services/" manage-orders/src/main/resources/config.properties
    sed -i "/^REPORT_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8040\/report\/services/" manage-orders/src/main/resources/config.properties
    sed -i "/^ORDER_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8010\/orders\/services/" manage-orders/src/main/resources/config.properties
    sed -i "/^ANALYSIS_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8030\/analysis\/services/" manage-orders/src/main/resources/config.properties
    sed -i "/^ALERT_MAIL_RECIPIENT/ s/=.*/=ruanjian@feezu.cn/" manage-orders/src/main/resources/config.properties
    sed -i "/^EXCLUDE_COM_CODE/ s/=.*/=BJCX001,BJCXQC001,GZWL001,YGMM001,BQXNY00001,HY00001/" manage-orders/src/main/resources/config.properties
    sed -i "/^TLD_URL/ s/=.*/=http:\/\/hlht.teld.cn:9201\/evcs\/v20161110\//" manage-orders/src/main/resources/config.properties

    # dubbo.properties
    sed -i '/^dubbo.registry.address/ s/=.*/=zookeeper:\/\/10.172.164.152:2181/' manage-orders/src/main/resources/dubbo.properties

    # ftpconfig.properties
    sed -i "/^img.ftp.host/ s/=.*/=imgprep.feezu.cn/" manage-orders/src/main/resources/ftpconfig.properties
    sed -i "/^img.http.host/ s/=.*/=imgprep.feezu.cn/" manage-orders/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxIdle/ s/=.*/=50/" manage-orders/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxActive/ s/=.*/=50/" manage-orders/src/main/resources/ftpconfig.properties

    # jdbc.properties 
    sed -i "/^masterdb.url/ s/=.*/=jdbc:mysql:\/\/rds8ei10r74e6ey5j592.mysql.rds.aliyuncs.com:3306\/orders?useUnicode=true\&amp;characterEncoding=utf-8/" manage-orders/src/main/resources/jdbc.properties
    sed -i "/^slavedb.url/ s/=.*/=jdbc:mysql:\/\/rr-2zea0j789ci31t3fy.mysql.rds.aliyuncs.com:3306\/orders?useUnicode=true\&amp;characterEncoding=utf-8/" manage-orders/src/main/resources/jdbc.properties
    sed -i "/db.user/ s/=.*/=mainuser/g" manage-orders/src/main/resources/jdbc.properties
    sed -i "/db.password/ s/=.*/=OgVT2DokWhzm/g" manage-orders/src/main/resources/jdbc.properties
    sed -i "/maxActive/ s/=.*/=500/g" manage-orders/src/main/resources/jdbc.properties
    sed -i "/initialSize/ s/=.*/=5/g" manage-orders/src/main/resources/jdbc.properties

    # jedis.properties
    sed -i "/^redis.host/ s/=.*/=redis_01/" manage-orders/src/main/resources/jedis.properties
    sed -i "/^redis.port/ s/=.*/=6379/" manage-orders/src/main/resources/jedis.properties
    sed -i "/^redis.timeout/ s/=.*/=8000/" manage-orders/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxIdle/ s/=.*/=200/" manage-orders/src/main/resources/jedis.properties
    sed -i "/^redis.pool.minIdle/ s/=.*/=30/" manage-orders/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxActive/ s/=.*/=2000/" manage-orders/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxWait/ s/=.*/=2000/" manage-orders/src/main/resources/jedis.properties

    # msgConfig.properties
    sed -i "/^msg.brokerURL/ s/=.*/=failover:\(tcp:\/\/10.172.164.152:61616,tcp:\/\/10.44.54.183:61616,tcp:\/\/10.162.198.246:61616\)/" manage-orders/src/main/resources/msgConfig.properties
    sed -i "/^amqp.addresses/ s/=.*/=10.172.91.66:5673/" manage-orders/src/main/resources/msgConfig.properties
    sed -i "/^amqp.password/ s/=.*/=prep123456/" manage-orders/src/main/resources/msgConfig.properties

    # refund.properties
    sed -i "/^user.applay.refund.peccancy/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/ali\/refundCallback/" manage-orders/src/main/resources/refund.properties

    # securityConfig.properties
    sed -i "/^SECURITY_KEY=/ s/=.*/=Dkwz8z8lJh94tPxP/" manage-orders/src/main/resources/securityConfig.properties
    sed -i "/SECURITY_KEY_VERSION=/ s/=.*/=160093/" manage-orders/src/main/resources/securityConfig.properties

    # spy.properties
    # no change

    # serverconfig.properties

    # log4j.xml
    sed -i '/<appender-ref ref="elkfile"\/>/d' manage-orders/src/main/resources/log4j.xml
    # no change

    # applicationContext-dubbo-consumer.xml
    sed -i '/dubbo:registry address/ s/=.*/="zookeeper:\/\/10.172.164.152:2181"\/>/' manage-orders/src/main/resources/applicationContext-dubbo-consumer.xml

	### report-superviser ###
    # config.properties
    sed -i "/^ METADATA_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8020\/metadata\/services/" report-superviser/src/main/resources/config.properties
    sed -i "/^ REPORT_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8040\/report\/services/" report-superviser/src/main/resources/config.properties

    # gbReportConfig.properties
    # no change

    # msgConfig.properties
    sed -i "/^msg.brokerURL/ s/=.*/=failover:\(tcp:\/\/10.172.164.152:61616,tcp:\/\/10.44.54.183:61616,tcp:\/\/10.162.198.246:61616\)/" report-superviser/src/main/resources/msgConfig.properties
    sed -i "/^amqp.addresses/ s/=.*/=10.172.91.66:5673/" report-superviser/src/main/resources/msgConfig.properties
    sed -i "/^amqp.password/ s/=.*/=prep123456/" report-superviser/src/main/resources/msgConfig.properties

    # tcpConfig.properties
    sed -i "/^tcp.address/ s/=.*/=180.153.44.206/"  report-superviser/src/main/resources/tcpConfig.properties
    sed -i "/^tcp.port/ s/=.*/=2863/"  report-superviser/src/main/resources/tcpConfig.properties

    # serverconfig.properties
	
	### manage-web ###
    # apollo-env.properties
    sed -i "/^server.env/ s/=.*/=uat/" manage-web/src/main/resources/apollo-env.properties
    sed -i "/^uat.meta/ s/=.*/=http:\/\/meta.apollo.uat.feezu.cn:8582/" manage-web/src/main/resources/apollo-env.properties
    sed -i "/^apollo.cluster/ s/=.*/=prep/" manage-web/src/main/resources/apollo-env.properties
    
    # config.properties
    sed -i "/^METADATA_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8020\/metadata\/services/" manage-web/src/main/resources/config.properties
    sed -i "/^REPORT_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8040\/report\/services/" manage-web/src/main/resources/config.properties
    sed -i "/^ORDER_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8010\/orders\/services/" manage-web/src/main/resources/config.properties
    sed -i "/^ANALYSIS_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8030\/analysis\/services/" manage-web/src/main/resources/config.properties
    sed -i "/^CAR_TYPE_REPORT_HREF/ s/=.*/=\/report\/storeCarTypeReport/" manage-web/src/main/resources/config.properties
    sed -i "/^IS_PRODUCT_ENVIRONMENT_VALID_CODE/ s/=.*/=true/" manage-web/src/main/resources/config.properties
    # 模拟登录
    # cur_2000376m6dg9 刘彦
    # cur_2000399vw66t 付建
    # cur_100038r57lpr 毛冲冲
    # cur_2000376m6dgk 方意
    # cur_200038mqlkrj 杨志强
    # cur_10004pvcfzxh 李佳航
    sed -i "/^ALLOW_CHANGE_LOGIN_IDS/ s/=.*/=cur_2000376m6dg9,cur_2000399vw66t,cur_100038r57lpr,cur_2000376m6dgk,cur_200038mqlkrj,cur_10004pvcfzxh/" manage-web/src/main/resources/config.properties
    sed -i "/^bill_police_to_mail/ s/=.*/=ruanjian@feezu.cn/" manage-web/src/main/resources/config.properties
    sed -i "/^qrcode_url/ s/=.*/=https:\/\/appprep.feezu.cn/" manage-web/src/main/resources/config.properties
    sed -i "/^OPEN_OTHERPICTURE_HANDSHOLD/ s/=.*/=BJCXQC001,YWX00001,DZ00001/" manage-web/src/main/resources/config.properties
    sed -i "/^FAST_DNF_URL/ s/=.*/=http:\/\/img.feezu.cn/" manage-web/src/main/resources/config.properties
    sed -i "/^WZC_LOGIN_IPS/ s/=.*/=111.200.241.178,111.200.241.179/" manage-web/src/main/resources/config.properties

    # fastdfs-client.properties
    sed -i "/^fastdfs.tracker_servers/ s/=.*/= 10.44.183.203:22122/" manage-web/src/main/resources/fastdfs-client.properties

    # ftpconfig.properties
    sed -i "/^img.ftp.host/ s/=.*/=imgprep.feezu.cn/" manage-web/src/main/resources/ftpconfig.properties
    sed -i "/^img.http.host/ s/=.*/=imgprep.feezu.cn/" manage-web/src/main/resources/ftpconfig.properties
    sed -i "/^img.device.host/ s/=.*/=101.200.175.64/" manage-web/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxIdle/ s/=.*/=50/" manage-web/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxActive/ s/=.*/=50/" manage-web/src/main/resources/ftpconfig.properties

    # jedis.properties
    sed -i "/^redis.host/ s/=.*/=redis_01/" manage-web/src/main/resources/jedis.properties
    sed -i "/^redis.port/ s/=.*/=6379/" manage-web/src/main/resources/jedis.properties
    sed -i "/^redis.timeout/ s/=.*/=8000/" manage-web/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxIdle/ s/=.*/=200/" manage-web/src/main/resources/jedis.properties
    sed -i "/^redis.pool.minIdle/ s/=.*/=30/" manage-web/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxActive/ s/=.*/=2000/" manage-web/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxWait/ s/=.*/=2000/" manage-web/src/main/resources/jedis.properties

    # applicationContext-dubbo-consumer.xml
    sed -i '/dubbo:registry address/ s/=.*/="zookeeper:\/\/10.172.164.152:2181"\/>/' manage-web/src/main/resources/applicationContext-dubbo-consumer.xml

	### manage-metadata ###
    # apollo-env.properties
    sed -i "/^server.env/ s/=.*/=uat/" manage-metadata/src/main/resources/apollo-env.properties
    sed -i "/^uat.meta/ s/=.*/=http:\/\/meta.apollo.uat.feezu.cn:8582/" manage-metadata/src/main/resources/apollo-env.properties
    sed -i "/^apollo.cluster/ s/=.*/=prep/" manage-metadata/src/main/resources/apollo-env.properties

    # dubbo.properties
    sed -i '/^dubbo.registry.address/ s/=.*/=zookeeper:\/\/10.172.164.152:2181/' manage-metadata/src/main/resources/dubbo.properties

    # ftpconfig.properties
    sed -i "/^img.ftp.host/ s/=.*/=imgprep.feezu.cn/" manage-metadata/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxIdle/ s/=.*/=50/" manage-metadata/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxActive/ s/=.*/=50/" manage-metadata/src/main/resources/ftpconfig.properties
    sed -i "/^img.http.host/ s/=.*/=imgprep.feezu.cn/" manage-metadata/src/main/resources/ftpconfig.properties
    sed -i "/^img.device.host/ s/=.*/=101.200.175.64/" manage-metadata/src/main/resources/ftpconfig.properties
    sed -i "/^FAST_DNF_URL/ s/=.*/=http:\/\/img.feezu.cn/" manage-metadata/src/main/resources/ftpconfig.properties

    # jdbc.properties 
    sed -i "/^masterdb.url/ s/=.*/=jdbc:mysql:\/\/rds8ei10r74e6ey5j592.mysql.rds.aliyuncs.com:3306\/wzc?useUnicode=true\&amp;characterEncoding=utf-8/" manage-metadata/src/main/resources/jdbc.properties
    sed -i "/^slavedb.url/ s/=.*/=jdbc:mysql:\/\/rr-2zea0j789ci31t3fy.mysql.rds.aliyuncs.com:3306\/wzc?useUnicode=true\&amp;characterEncoding=utf-8/" manage-metadata/src/main/resources/jdbc.properties
    sed -i "/db.user/ s/=.*/=mainuser/g" manage-metadata/src/main/resources/jdbc.properties
    sed -i "/db.password/ s/=.*/=OgVT2DokWhzm/g" manage-metadata/src/main/resources/jdbc.properties
    sed -i "/maxActive/ s/=.*/=500/g" manage-metadata/src/main/resources/jdbc.properties
    sed -i "/initialSize/ s/=.*/=5/g" manage-metadata/src/main/resources/jdbc.properties

    # jedis.properties
    sed -i "/^redis.host/ s/=.*/=redis_01/" manage-metadata/src/main/resources/jedis.properties
    sed -i "/^redis.port/ s/=.*/=6379/" manage-metadata/src/main/resources/jedis.properties
    sed -i "/^redis.timeout/ s/=.*/=8000/" manage-metadata/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxIdle/ s/=.*/=200/" manage-metadata/src/main/resources/jedis.properties
    sed -i "/^redis.pool.minIdle/ s/=.*/=30/" manage-metadata/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxActive/ s/=.*/=2000/" manage-metadata/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxWait/ s/=.*/=2000/" manage-metadata/src/main/resources/jedis.properties

    # msgConfig.properties
    sed -i "/^msg.brokerURL/ s/=.*/=failover:\(tcp:\/\/10.172.164.152:61616,tcp:\/\/10.44.54.183:61616,tcp:\/\/10.162.198.246:61616\)/" manage-metadata/src/main/resources/msgConfig.properties
    sed -i "/^amqp.addresses/ s/=.*/=10.172.91.66:5673/" manage-metadata/src/main/resources/msgConfig.properties
    sed -i "/^amqp.password/ s/=.*/=prep123456/" manage-metadata/src/main/resources/msgConfig.properties

    # securityConfig.properties
    sed -i "/SECURITY_KEY=/ s/=.*/=Dkwz8z8lJh94tPxP/" manage-metadata/src/main/resources/securityConfig.properties
    sed -i "/SECURITY_KEY_VERSION=/ s/=.*/=160093/" manage-metadata/src/main/resources/securityConfig.properties
    # sms.properties
    # no change

    # serverconfig.properties

    # log4j.xml
    sed -i '/<appender-ref ref="elkfile"\/>/d' manage-metadata/src/main/resources/log4j.xml
    # no change


	### manage-datawarehouse ###
    # jedis.properties
    #sed -i "/^redis.host/ s/=.*/=redis_01/" manage-datawarehouse/src/main/resources/jedis.properties
    #sed -i "/^redis.port/ s/=.*/=6379/" manage-datawarehouse/src/main/resources/jedis.properties
    #sed -i "/^redis.timeout/ s/=.*/=8000/" manage-datawarehouse/src/main/resources/jedis.properties
    #sed -i "/^redis.pool.maxIdle/ s/=.*/=200/" manage-datawarehouse/src/main/resources/jedis.properties
    #sed -i "/^redis.pool.minIdle/ s/=.*/=30/" manage-datawarehouse/src/main/resources/jedis.properties
    #sed -i "/^redis.pool.maxActive/ s/=.*/=2000/" manage-datawarehouse/src/main/resources/jedis.properties
    #sed -i "/^redis.pool.maxWait/ s/=.*/=2000/" manage-datawarehouse/src/main/resources/jedis.properties

    # msgConfig.properties
    #sed -i "/^msg.brokerURL/ s/=.*/=failover:\(tcp:\/\/10.172.164.152:61616,tcp:\/\/10.44.54.183:61616,tcp:\/\/10.162.198.246:61616\)/" manage-datawarehouse/src/main/resources/msgConfig.properties
    #sed -i "/^amqp.addresses/ s/=.*/=10.172.91.66:5673,10.171.37.50:5673/" manage-datawarehouse/src/main/resources/msgConfig.properties
    #sed -i "/^amqp.password/ s/=.*/=prep123456/" manage-datawarehouse/src/main/resources/msgConfig.properties

    # serverconfig.properties

    # log4j.xml
    # no change

    # hbase-site.xml
    #sed -i "s/hdfs:\/\/hbase.feezu.cn/hdfs:\/\/10.162.198.246/" manage-datawarehouse/src/main/resources/hbase-site.xml
    #sed -i "s/>1</>3</" manage-datawarehouse/src/main/resources/hbase-site.xml
    #sed -i "s/>hbase.feezu.cn:60000</>10.162.198.246:16000</" manage-datawarehouse/src/main/resources/hbase-site.xml
    #sed -i "s/>hbase.feezu.cn</>10.162.198.246</" manage-datawarehouse/src/main/resources/hbase-site.xml
    #sed -i "s/>false</>true</" manage-datawarehouse/src/main/resources/hbase-site.xml

	### wechat ###
    # acp_sdk.properties
    # no change

    # config.properties
    sed -i "/^METADATA_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8020\/metadata\/services/" wechat/src/main/resources/config.properties
    sed -i "/^ORDER_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8010\/orders\/services/" wechat/src/main/resources/config.properties
    sed -i "/^Request.ConsumerApp.Url/ s/=.*/=https:\/\/appprep.feezu.cn/" wechat/src/main/resources/config.properties
    sed -i "/^YwxWeiXin.Url/ s/=.*/=https:\/\/prepwx.feezu.cn/" wechat/src/main/resources/config.properties

    # jedis.properties
    sed -i "/^redis.host/ s/=.*/=redis_01/" wechat/src/main/resources/jedis.properties
    sed -i "/^redis.port/ s/=.*/=6379/" wechat/src/main/resources/jedis.properties
    sed -i "/^redis.timeout/ s/=.*/=8000/" wechat/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxIdle/ s/=.*/=200/" wechat/src/main/resources/jedis.properties
    sed -i "/^redis.pool.minIdle/ s/=.*/=30/" wechat/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxActive/ s/=.*/=2000/" wechat/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxWait/ s/=.*/=2000/" wechat/src/main/resources/jedis.properties

    # base.js
    sed -i "/apiUrl/ s/\/\/.*/\/\/appprep.feezu.cn',/" wechat/WebContent/resources/js/base.js

    # log4j.xml
    # no change

	### manage-app ###
	# config.properties 
    sed -i "/^METADATA_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8020\/metadata\/services/" manage-app/src/main/resources/config.properties
    sed -i "/^REPORT_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8040\/report\/services/" manage-app/src/main/resources/config.properties
    sed -i "/^ORDER_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8010\/orders\/services/" manage-app/src/main/resources/config.properties

    # jedis.properties
    sed -i "/^redis.host/ s/=.*/=redis_01/" manage-app/src/main/resources/jedis.properties
    sed -i "/^redis.port/ s/=.*/=6379/" manage-app/src/main/resources/jedis.properties
    sed -i "/^redis.timeout/ s/=.*/=8000/" manage-app/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxIdle/ s/=.*/=200/" manage-app/src/main/resources/jedis.properties
    sed -i "/^redis.pool.minIdle/ s/=.*/=30/" manage-app/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxActive/ s/=.*/=2000/" manage-app/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxWait/ s/=.*/=2000/" manage-app/src/main/resources/jedis.properties

    # log4j.xml
    # no change

	### manage-report ###
    # acp_sdk.properties
    sed -i "/^create_backURL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/unionpay\/callback/" manage-report/src/main/resources/acp_sdk.properties
    sed -i "/^finish_backURL/ s/=.*/=https:\/\/111.200.241.178\/manage\/orderpayment\/notify4finishOrder/" manage-report/src/main/resources/acp_sdk.properties
    sed -i "/^create_renew_backURL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/unionpay\/callbackRenew/" manage-report/src/main/resources/acp_sdk.properties
    sed -i "/^refund_backURL/ s/=.*/=https:\/\/appprep.feezu.cn\/payment\/unionpay\/refundCallback/" manage-report/src/main/resources/acp_sdk.properties

    # apollo-env.properties
    sed -i "/^server.env/ s/=.*/=uat/" manage-report/src/main/resources/apollo-env.properties
    sed -i "/^uat.meta/ s/=.*/=http:\/\/meta.apollo.uat.feezu.cn:8582/" manage-report/src/main/resources/apollo-env.properties
    sed -i "/^apollo.cluster/ s/=.*/=prep/" manage-report/src/main/resources/apollo-env.properties

    # config.properties
    sed -i "/^METADATA_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8020\/metadata\/services/" manage-report/src/main/resources/config.properties
    sed -i "/^REPORT_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8040\/report\/services/" manage-report/src/main/resources/config.properties
    sed -i "/^ORDER_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8010\/orders\/services/" manage-report/src/main/resources/config.properties
    sed -i "/^ANALYSIS_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8030\/analysis\/services/" manage-report/src/main/resources/config.properties
    sed -i "/^bill_police_to_mail/ s/=.*/=chanpin@feezu.cn/" manage-report/src/main/resources/config.properties
    sed -i "/^ALERT_MAIL_RECIPIENT/ s/=.*/=ruanjian@feezu.cn/" manage-report/src/main/resources/config.properties
    sed -i "/^ALERT_MAIL_CAIWU/ s/=.*/=ruanjian@feezu.cn/" manage-report/src/main/resources/config.properties

    # ftpconfig.properties
    sed -i "/^img.ftp.host/ s/=.*/=imgprep.feezu.cn/" manage-report/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxIdle/ s/=.*/=50/" manage-report/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxActive/ s/=.*/=50/" manage-report/src/main/resources/ftpconfig.properties
    sed -i "/^img.http.host/ s/=.*/=imgprep.feezu.cn/" manage-report/src/main/resources/ftpconfig.properties

    # jdbc.properties
    sed -i "/^wzc.db.url/ s/=.*/=jdbc:mysql:\/\/rds8ei10r74e6ey5j592.mysql.rds.aliyuncs.com:3306\/wzc?useUnicode=true\&amp;characterEncoding=utf-8/" manage-report/src/main/resources/jdbc.properties
    sed -i "/^order.db.url/ s/=.*/=jdbc:mysql:\/\/rds8ei10r74e6ey5j592.mysql.rds.aliyuncs.com:3306\/orders?useUnicode=true\&amp;characterEncoding=utf-8/" manage-report/src/main/resources/jdbc.properties
    sed -i "/^masterdb.url/ s/=.*/=jdbc:mysql:\/\/rds8ei10r74e6ey5j592.mysql.rds.aliyuncs.com:3306\/report?useUnicode=true\&amp;characterEncoding=utf-8/" manage-report/src/main/resources/jdbc.properties
    sed -i "/^slavedb.url/ s/=.*/=jdbc:mysql:\/\/rr-2zea0j789ci31t3fy.mysql.rds.aliyuncs.com:3306\/report?useUnicode=true\&amp;characterEncoding=utf-8/" manage-report/src/main/resources/jdbc.properties
    sed -i "/db.user/ s/=.*/=mainuser/g" manage-report/src/main/resources/jdbc.properties
    sed -i "/db.password/ s/=.*/=OgVT2DokWhzm/g" manage-report/src/main/resources/jdbc.properties
    sed -i "/maxActive/ s/=.*/=500/g" manage-report/src/main/resources/jdbc.properties
    sed -i "/initialSize/ s/=.*/=5/g" manage-report/src/main/resources/jdbc.properties
    # jedis.properties
    sed -i "/^redis.host/ s/=.*/=redis_01/" manage-report/src/main/resources/jedis.properties
    sed -i "/^redis.port/ s/=.*/=6379/" manage-report/src/main/resources/jedis.properties
    sed -i "/^redis.timeout/ s/=.*/=8000/" manage-report/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxIdle/ s/=.*/=200/" manage-report/src/main/resources/jedis.properties
    sed -i "/^redis.pool.minIdle/ s/=.*/=30/" manage-report/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxActive/ s/=.*/=2000/" manage-report/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxWait/ s/=.*/=2000/" manage-report/src/main/resources/jedis.properties
    # msgConfig.properties
    sed -i "/^msg.brokerURL/ s/=.*/=failover:\(tcp:\/\/10.172.164.152:61616,tcp:\/\/10.44.54.183:61616,tcp:\/\/10.162.198.246:61616\)/" manage-report/src/main/resources/msgConfig.properties
    sed -i "/^amqp.addresses/ s/=.*/=10.172.91.66:5673/" manage-report/src/main/resources/msgConfig.properties
    sed -i "/^amqp.password/ s/=.*/=prep123456/" manage-report/src/main/resources/msgConfig.properties
    # securityConfig.properties
    sed -i "/^SECURITY_KEY=/ s/=.*/=Dkwz8z8lJh94tPxP/" manage-report/src/main/resources/securityConfig.properties
    sed -i "/SECURITY_KEY_VERSION=/ s/=.*/=160093/" manage-report/src/main/resources/securityConfig.properties
    # spy.properties
    # no change

    # serverconfig.properties

    # applicationContext-dubbo-consumer.xml
    sed -i '/dubbo:registry address/ s/=.*/="zookeeper:\/\/10.172.164.152:2181"\/>/' manage-report/src/main/resources/applicationContext-dubbo-consumer.xml

    # log4j.xml
    sed -i '/<appender-ref ref="elkfile"\/>/d' manage-report/src/main/resources/log4j.xml
    # no change

	### manage-thirdparty ###
    # config.properties
    # no change
    # dubbo.properties
    sed -i '/^dubbo.registry.address/ s/=.*/=zookeeper:\/\/10.172.164.152:2181/' manage-thirdparty/src/main/resources/dubbo.properties
    # ftpconfig.properties
    sed -i "/^img.ftp.host/ s/=.*/=imgprep.feezu.cn/" manage-thirdparty/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxIdle/ s/=.*/=50/" manage-thirdparty/src/main/resources/ftpconfig.properties
    sed -i "/^img.ftp.maxActive/ s/=.*/=50/" manage-thirdparty/src/main/resources/ftpconfig.properties
    sed -i "/^img.http.host/ s/=.*/=imgprep.feezu.cn/" manage-thirdparty/src/main/resources/ftpconfig.properties
    # jdbc.properties
    sed -i "/^db.url/ s/=.*/=jdbc:mysql:\/\/rds8ei10r74e6ey5j592.mysql.rds.aliyuncs.com:3306\/thirdparty?useUnicode=true\&amp;characterEncoding=utf-8/" manage-thirdparty/src/main/resources/jdbc.properties
    sed -i "/^db.user/ s/=.*/=mainuser/g" manage-thirdparty/src/main/resources/jdbc.properties
    sed -i "/^db.password/ s/=.*/=OgVT2DokWhzm/g" manage-thirdparty/src/main/resources/jdbc.properties
    sed -i "/maxActive/ s/=.*/=500/g" manage-thirdparty/src/main/resources/jdbc.properties
    sed -i "/initialSize/ s/=.*/=5/g" manage-thirdparty/src/main/resources/jdbc.properties
    # securityConfig.properties
    sed -i "/^SECURITY_KEY=/ s/=.*/=Dkwz8z8lJh94tPxP/" manage-thirdparty/src/main/resources/securityConfig.properties
    sed -i "/SECURITY_KEY_VERSION=/ s/=.*/=160093/" manage-thirdparty/src/main/resources/securityConfig.properties

    # serverconfig.properties
    #log4j.xml
    # no change

    ### download ###
    # server.properties
    # no change

    # log4j.xml
    # no change

	### consumer-wap ###
    # config.properties
    sed -i "/^METADATA_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8020\/metadata\/services/" consumer-wap/src/main/resources/config.properties
    sed -i "/^ORDER_WEB_SERVICE_DOMAIN/ s/=.*/=http:\/\/service_01:8010\/orders\/services/" consumer-wap/src/main/resources/config.properties
    sed -i "/^CONSUMER_APP_URL/ s/=.*/=https:\/\/appprep.feezu.cn/" consumer-wap/src/main/resources/config.properties

    # jedis.properties
    sed -i "/^redis.host/ s/=.*/=redis_01/" consumer-wap/src/main/resources/jedis.properties
    sed -i "/^redis.port/ s/=.*/=6379/" consumer-wap/src/main/resources/jedis.properties
    sed -i "/^redis.timeout/ s/=.*/=8000/" consumer-wap/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxIdle/ s/=.*/=200/" consumer-wap/src/main/resources/jedis.properties
    sed -i "/^redis.pool.minIdle/ s/=.*/=30/" consumer-wap/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxActive/ s/=.*/=2000/" consumer-wap/src/main/resources/jedis.properties
    sed -i "/^redis.pool.maxWait/ s/=.*/=2000/" consumer-wap/src/main/resources/jedis.properties
    # log4j.xml
    # no change

    # 按不同的后端服务器修改serverconfig.properties
	PS3="目标服务器: "
	select option in "TOMCAT1" "TOMCAT2";do
	case $option in
    	TOMCAT1)
			REMOTE_ENV=TOMCAT1
			REMOTE_SERVER=123.57.66.230
            #sed -i "/^serverId/ s/=.*/=analysis_prep_1/" manage-datawarehouse/src/main/resources/serverconfig.properties
    		#sed -i "/^groupServerId/ s/=.*/=1/" manage-datawarehouse/src/main/resources/serverconfig.properties

            sed -i "/^serverId/ s/=.*/=metadata_prep_1/" manage-metadata/src/main/resources/serverconfig.properties
    		sed -i "/^groupServerId/ s/=.*/=1/" manage-metadata/src/main/resources/serverconfig.properties
    		sed -i "/^STATION_CARS_CHECK_COMPANYID/ s/=.*/=com_10001dgjp3jl,com_1000220lccvg/" manage-metadata/src/main/resources/serverconfig.properties
            sed -i "/^RUNNING_ENVIRONMENT/ s/=.*/=prep/" manage-metadata/src/main/resources/serverconfig.properties
            sed -i "/^IOT_TENANT_ACCOUNT/ s/=.*/=tc_ywx/" manage-metadata/src/main/resources/serverconfig.properties
            sed -i "/^IOT_PASSWORD/ s/=.*/=13811145125/" manage-metadata/src/main/resources/serverconfig.properties
            sed -i "/^MAINT_ADDRESS/ s/=.*/=http:\/\/yunwei.feezu.cn/" manage-metadata/src/main/resources/serverconfig.properties

            sed -i "/^serverId/ s/=.*/=orders_prep_1/" manage-orders/src/main/resources/serverconfig.properties
    		sed -i "/^groupServerId/ s/=.*/=1/" manage-orders/src/main/resources/serverconfig.properties

            sed -i "/^serverId/ s/=.*/=superviser_prep_1/" report-superviser/src/main/resources/serverconfig.properties
    		sed -i "/^groupServerI/ s/=.*/=1/" report-superviser/src/main/resources/serverconfig.properties

            sed -i "/^serverId/ s/=.*/=report_prep_1/" manage-report/src/main/resources/serverconfig.properties
    		sed -i "/^groupServerId/ s/=.*/=1/" manage-report/src/main/resources/serverconfig.properties

            sed -i "/^serverId/ s/=.*/=thirdparty_prep_1/" manage-thirdparty/src/main/resources/serverconfig.properties
    		sed -i "/^groupServerId/ s/=.*/=1/" manage-thirdparty/src/main/resources/serverconfig.properties

			break
		;;
    	TOMCAT2)
			REMOTE_ENV=TOMCAT2
			REMOTE_SERVER=123.56.239.95
            #sed -i "/^serverId/ s/=.*/=analysis_prep_2/" manage-datawarehouse/src/main/resources/serverconfig.properties
    		#sed -i "/^groupServerId/ s/=.*/=2/" manage-datawarehouse/src/main/resources/serverconfig.properties

            sed -i "/^serverId/ s/=.*/=metadata_prep_2/" manage-metadata/src/main/resources/serverconfig.properties
    		sed -i "/^groupServerId/ s/=.*/=2/" manage-metadata/src/main/resources/serverconfig.properties
    		sed -i "/^STATION_CARS_CHECK_COMPANYID/ s/=.*/=com_10001dgjp3jl,com_1000220lccvg/" manage-metadata/src/main/resources/serverconfig.properties
            sed -i "/^RUNNING_ENVIRONMENT/ s/=.*/=prep/" manage-metadata/src/main/resources/serverconfig.properties
            sed -i "/^IOT_TENANT_ACCOUNT/ s/=.*/=tc_ywx/" manage-metadata/src/main/resources/serverconfig.properties
            sed -i "/^IOT_PASSWORD/ s/=.*/=13811145125/" manage-metadata/src/main/resources/serverconfig.properties
            sed -i "/^MAINT_ADDRESS/ s/=.*/=http:\/\/yunwei.feezu.cn/" manage-metadata/src/main/resources/serverconfig.properties

            sed -i "/^serverId/ s/=.*/=orders_prep_2/" manage-orders/src/main/resources/serverconfig.properties
    		sed -i "/^groupServerId/ s/=.*/=2/" manage-orders/src/main/resources/serverconfig.properties

            sed -i "/^serverId/ s/=.*/=superviser_prep_2/" report-superviser/src/main/resources/serverconfig.properties
    		sed -i "/^groupServerId/ s/=.*/=2/" report-superviser/src/main/resources/serverconfig.properties

            sed -i "/^serverId/ s/=.*/=report_prep_2/" manage-report/src/main/resources/serverconfig.properties
    		sed -i "/^groupServerId/ s/=.*/=2/" manage-report/src/main/resources/serverconfig.properties

            sed -i "/^serverId/ s/=.*/=thirdparty_prep_2/" manage-thirdparty/src/main/resources/serverconfig.properties
    		sed -i "/^groupServerId/ s/=.*/=2/" manage-thirdparty/src/main/resources/serverconfig.properties

			break
		;;
        *)
       		clear
        	echo "Error! Wrong choice!"
        	exit
    	;;
	esac
	done
}

function GET_READY_FOR_GATEWAY() {
    trap 'ERRTRAP $LINENO' ERR
	PS3="设备版本: "
	select option in "1.0" "2.0";do
	case $option in
    	1.0)
        	DEVICE_ENV=1.0
        	break
        ;;
    	2.0)
        	DEVICE_ENV=2.0
        	break
    	;;
    	*)
        	clear
        	echo "Error! Wrong choice!"
        	exit
    	;;
	esac
	done
}

function GET_READY_FOR_DM() {
    trap 'ERRTRAP $LINENO' ERR
    UNALIAS_CP
    cd ${DM_SOURCE_DIR}/device-manage-web/src/main/resources
	if [ -f "dubbo.properties" ];then
    	rm -f dubbo.properties
	fi

	if [ -f "gateway-deliver-config.properties" ];then
    	rm -f gateway-deliver-config.properties
	fi

	if [ -f "serverconfig.config.properties" ];then
    	rm -f serverconfig.properties
	fi
	cp -f dubbo.properties.template dubbo.properties
	cp -f gateway-deliver-config.properties.template gateway-deliver-config.properties
	cp -f serverconfig.properties.template serverconfig.properties

    cd ${DM_SOURCE_DIR}/device-manage-service/src/main/resources
	if [ -f "hbase-site.xml" ];then
    	rm -f hbase-site.xml
	fi
    cp -f hbase-site.xml.template hbase-site.xml

	PS3="目标环境: "
	select option in "prep" "product";do
	case $option in
    	prep)
        	REMOTE_ENV=prep
            cd ${DM_SOURCE_DIR}/device-manage-web/src/main/resources
            # dobbo.properties
			sed -i "/dubbo.registry.address/ s/=.*/=zookeeper:\/\/10.172.164.152:2181?client=zkclient/" dubbo.properties
			sed -i "/dubbo.protocol.port/ s/20018/20019/" dubbo.properties
            # gateway-deliver-config.properties
			sed -i "/jdbc.url/ s/mysql:\/\/.*:3306/mysql:\/\/rds8ei10r74e6ey5j592.mysql.rds.aliyuncs.com:3306/g" gateway-deliver-config.properties
			sed -i "/jdbc.username/ s/=.*/=mainuser/g" gateway-deliver-config.properties
			sed -i "/jdbc.password/ s/=.*/=OgVT2DokWhzm/g" gateway-deliver-config.properties
			sed -i "/redis.host/ s/=.*/=redis_01/" gateway-deliver-config.properties
			sed -i "/^file.ftp.host/ s/=.*/=10.44.154.154/" gateway-deliver-config.properties
			sed -i "/^file.http.host/ s/=.*/=imgprep.feezu.cn/" gateway-deliver-config.properties
			sed -i "/^file.device.host/ s/=.*/=101.200.175.64/" gateway-deliver-config.properties
            sed -i "/^msg.brokerURL/ s/=.*/=failover:\(tcp:\/\/10.172.164.152:61616,tcp:\/\/10.44.54.183:61616,tcp:\/\/10.162.198.246:61616\)/" gateway-deliver-config.properties
            sed -i "/^rabbitmq.dm.addresses/ s/=.*/=10.172.91.66:5673/" gateway-deliver-config.properties
            sed -i "/^rabbitmq.dm.username/ s/=.*/=wzc/" gateway-deliver-config.properties
            sed -i "/^rabbitmq.dm.password/ s/=.*/=prep123456/" gateway-deliver-config.properties
            # serverconfig.properties

            cd ${DM_SOURCE_DIR}/device-manage-service/src/main/resources
            # hbase-site.xml
    		sed -i "s/hdfs:\/\/hbase.feezu.cn/hdfs:\/\/10.162.198.246/" hbase-site.xml
    		#sed -i "s/>1</>3</" hbase-site.xml 
    		sed -i "s/>hbase.feezu.cn:60000</>10.162.198.246:16000</" hbase-site.xml
    		sed -i "s/>hbase.feezu.cn</>10.162.198.246</" hbase-site.xml
    		sed -i "s/>false</>true</" hbase-site.xml
        	break
        ;;
    	product)
        	REMOTE_ENV=product
			# hbase-site.xml
            cd ${DM_SOURCE_DIR}/device-manage-service/src/main/resources
    		sed -i "s/hdfs:\/\/hbase.feezu.cn/hdfs:\/\/K-master/" hbase-site.xml
    		sed -i "s/>1</>3</" hbase-site.xml
    		sed -i "s/>hbase.feezu.cn:60000</>K-master:16000</" hbase-site.xml
    		sed -i "s/>hbase.feezu.cn</>K-slave1,K-slave2,K-slave3</" hbase-site.xml
    		sed -i "s/>false</>true</" hbase-site.xml

            # dubbo.properties
            cd ${DM_SOURCE_DIR}/device-manage-web/src/main/resources
			sed -i "/dubbo.registry.address/ s/=.*/=zookeeper:\/\/10.171.51.137:2181?backup=10.171.117.54:2181,10.44.52.77:2181/" dubbo.properties
			sed -i "/dubbo.protocol.port/ s/20018/20019/" dubbo.properties

            # serverconfig.properties
            sed -i "/^IOT_TENANT_ACCOUNT/ s/=.*/=tc_ywx/" serverconfig.properties
            sed -i "/^IOT_PASSWORD/ s/=.*/=13811145125/" serverconfig.properties

            # gateway-deliver-config.properties
			sed -i "/jdbc.url/ s/mysql:\/\/.*:3306/mysql:\/\/rdsk03oijx73u4fa8305.mysql.rds.aliyuncs.com:3306/g" gateway-deliver-config.properties
			sed -i "/devicecloud.jdbc.username/ s/=.*/=device_clound/" gateway-deliver-config.properties
			sed -i "/devicecloud.jdbc.password/ s/=.*/=uAVUgmAdbW5Vw6N/" gateway-deliver-config.properties
			sed -i "/wzc.jdbc.username/ s/=.*/=mainuser/" gateway-deliver-config.properties
			sed -i "/wzc.jdbc.password/ s/=.*/=NbcbKCSTQpa/" gateway-deliver-config.properties
			sed -i "/redis.host/ s/=.*/=redis_01/" gateway-deliver-config.properties
			sed -i "/redis.port/ s/=.*/=9000/" gateway-deliver-config.properties
			sed -i "/^file.ftp.host/ s/=.*/=10.27.81.198/" gateway-deliver-config.properties
			sed -i "/^file.http.host/ s/=.*/=img.feezu.cn/" gateway-deliver-config.properties
			sed -i "/^file.device.host/ s/=.*/=59.110.40.80/" gateway-deliver-config.properties
            sed -i "/^msg.brokerURL/ s/=.*/=failover:\(tcp:\/\/10.172.191.112:61616,tcp:\/\/10.170.202.109:61616,tcp:\/\/10.171.57.30:61616\)?randomize=false\&priorityBackup=true\&priorityURIs=tcp:\/\/10.170.202.109:61616,tcp:\/\/10.171.57.30:61616/" gateway-deliver-config.properties
            sed -i "/^rabbitmq.dm.addresses/ s/=.*/=10.27.74.214:5673,10.30.47.36:5673,10.30.57.7:5673/" gateway-deliver-config.properties
            sed -i "/^rabbitmq.dm.username/ s/=.*/=wzc/" gateway-deliver-config.properties
            sed -i "/^rabbitmq.dm.password/ s/=.*/=DFDeoDh9P4Y4HprN/" gateway-deliver-config.properties
            # 按不同的后端服务器修改serverID
    		PS3="目标服务器: "
    		select option in "SERVER1" "SERVER2";do
    		case $option in
        		SERVER1)
					sed -i "/^serverId/ s/=.*/=device-manage-pro-1/" gateway-deliver-config.properties
        			break
				;;
				SERVER2)
					sed -i "/^serverId/ s/=.*/=device-manage-pro-2/" gateway-deliver-config.properties
        			break
				;;
				*)
        			clear
        			echo "Error! Wrong choice!"
        			exit
    			;;
			esac
			done
            break
    	;;
    	*)
        	clear
        	echo "Error! Wrong choice!"
        	exit
    	;;
	esac
	done
}

function GET_READY_FOR_DL() {
    trap 'ERRTRAP $LINENO' ERR
    UNALIAS_CP

    cd ${GATEWAY_SOURCE_DIR}/devicelb/src/main/resources
	if [ -f "application.properties" ];then
    	rm -f application.properties
	fi

	cp -f application.properties.template application.properties

	PS3="目标环境: "
	select option in "prep" "product";do
	case $option in
    	prep)
        	REMOTE_ENV=prep
			#sed -i "/tcp-server.port/ s/=.*/=9981/" application.properties
			sed -i "/tcp-server.id/ s/=.*/=devicelb_pre/" application.properties
            sed -i "/mq.broker-url/ s/=.*/=failover:(tcp:\/\/10.172.164.152:61616,tcp:\/\/10.44.54.183:61616,tcp:\/\/10.162.198.246:61616)/" application.properties
			sed -i "/spring.dubbo.registry.address/ s/=.*/=zookeeper:\/\/10.172.164.152:2181/" application.properties
        	break
        ;;
    	product)
        	REMOTE_ENV=product
	        PS3="目标服务器: "
	        select option in "server1" "server2";do
	        case $option in
                server1)
			        sed -i "/tcp-server.port/ s/=.*/=9981/" application.properties
			        sed -i "/tcp-server.id/ s/=.*/=devicelb_pro_s1/" application.properties
			        sed -i "/mq.broker-url/ s/=.*/=tcp:\/\/10.165.119.188:61616/" application.properties
			        sed -i "/spring.dubbo.registry.address/ s/=.*/=zookeeper:\/\/10.171.51.137:2181?backup=10.171.117.54:2181,10.44.52.77:2181/" application.properties
			        sed -i "/spring.dubbo.protocol.port/ s/=.*/=20880/" application.properties
        	        break
    	        ;;
                server2)
			        sed -i "/tcp-server.port/ s/=.*/=9981/" application.properties
			        sed -i "/tcp-server.id/ s/=.*/=devicelb_pro_s2/" application.properties
			        sed -i "/mq.broker-url/ s/=.*/=tcp:\/\/10.165.119.188:61616/" application.properties
			        sed -i "/spring.dubbo.registry.address/ s/=.*/=zookeeper:\/\/10.171.51.137:2181?backup=10.171.117.54:2181,10.44.52.77:2181/" application.properties
			        sed -i "/spring.dubbo.protocol.port/ s/=.*/=20880/" application.properties
        	        break
    	        ;;

    	        *)
        	        clear
        	        echo "Error! Wrong choice!"
        	        exit
    	        ;;
	        esac
	        done
            break
        ;;
    	*)
        	clear
        	echo "Error! Wrong choice!"
        	exit
    	;;
	esac
	done
}

function DEFINE_SYSTEM_PATH() {
   : ${JAVA_HOME:="/Data/app/jdk1.8.0_162"} ${CLASS_PATH:="${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar"} ${MVN_HOME:="/Data/app/apache-maven-3.3.3"} ${GROOVY_HOME:="/Data/app/groovy-2.4.11"} ${PATH:="$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin:$GROOVY_HOME/bin"}
   export JAVA_HOME CLASS_PATH MAVEN_HOME GROOVY_HOME PATH
}

function DEFINE_VARIABLES() {
    : ${WZC3_SOURCE_DIR:="/Data/source/wzc3.0"} ${YUNWEI_SOURCE_DIR:="/Data/source/backoffice"} ${API_SOURCE_DIR:="/Data/source/device-api"} ${SETUP_SOURCE_DIR:="/Data/source/setup"} ${EXTGATEWAY_SOURCE_DIR:="/Data/source/external-gateway"} ${DM_SOURCE_DIR:="/Data/source/device-manage"} ${MANAGE_SOURCE_DIR:="/Data/source/Platform/platform"} ${MINA_SOURCE_DIR:="/Data/source/Mina/mina"} ${WZC_SOURCE_DIR:="/Data/source/Mina/mina/wzc"} ${GATEWAY_SOURCE_DIR:="/Data/source/device-gateway"} ${CONF_DIR:="src/main/resources"} ${SYNC_USER:="rsync_user"} ${SSH_PORT:="5122"} ${RSYNC_MODULE:="platform"} ${TOMCAT1:="10.51.84.95"} ${TOMCAT2:="10.47.138.177"} ${EXTERNAL_SOURCE_DIR:="/Data/source/external"}

    export YUNWEI_SOURCE_DIR API_SOURCE_DIR SETUP_SOURCE_DIR EXTGATEWAY_SOURCE_DIR DM_SOURCE_DIR MANAGE_SOURCE_DIR MINA_SOURCE_DIR WZC_SOURCE_DIR GATEWAY_SOURCE_DIR  CONF_DIR SYNC_USER SSH_PORT RSYNC_MODULE  TOMCAT1 TOMCAT2 TOMCAT3 EXTERNAL_SOURCE_DIR
}


# End
