//
//  MXChannel.m
//  Masonry
//
//  Created by FEI on 2019/3/30.
//

#import "MXChannel.h"

@implementation MXChannel
static  MXChannel*sharedChannel;
#pragma mark - 单例
+(id)sharedChannel{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedChannel=[[MXChannel alloc] init];
        sharedChannel.channelToken = [sharedChannel getChannel];
    });
    return sharedChannel;
}

+(void)hungeSoftCheckWithCallBack:(void(^)(NSString *res))callBack {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSArray *test = @[@"weixin",
                          @"mqq",
                          @"mqqiapi",
                          @"sinaweibo",
                          @"weico",
                          @"BaiduSSO",
                          @"renren",
                          @"tianya",
                          @"douban",
                          @"com.baidu.tieba",
                          @"neihan",
                          @"lkjhgfddsa",
                          @"tantanapp",
                          @"momochat",
                          @"alipay",
                          @"baiduyun",
                          @"sinavdisk",
                          @"weiyun",
                          @"imeituan",
                          @"dianping",
                          @"openrice",
                          @"bainuo",
                          @"koubei",
                          @"fleamarket",
                          @"zhuanzhuan",
                          @"tmall",
                          @"openapp.jdmoble",
                          @"taobao",
                          @"wccbyihaodian",
                          @"vipshop",
                          @"com.amazon.mobile.shopping",
                          @"dangdang",
                          @"com.suning.SuningEBuy",
                          @"zhe800",
                          @"pinduoduo",
                          @"sdjj",
                          @"xhsdiscover",
                          @"qyer",
                          @"travelguide",
                          @"taobaotravel",
                          @"TUNIUAPP",
                          @"Lvmama",
                          @"baidutravel",
                          @"ctrip",
                          @"QunariPhone",
                          @"com.qunar.gonglue",
                          @"yelp",
                          @"tripadvisor",
                          @"com.lonelyplanet.guides",
                          @"app16fan",
                          @"elongIPhone",
                          @"cyinspiration",
                          @"breadtravel",
                          @"planner",
                          @"umetrip",
                          @"tianxunchina",
                          @"hbgjfree",
                          @"veryzhunfree",
                          @"AirChina",
                          @"ceair",
                          @"SpringAirlines",
                          @"lkjhgfddsa",
                          @"youdao.trans",
                          @"yddictproapp",
                          @"googletranslate",
                          @"qctranslator",
                          @"voiceguide",
                          @"wxef72b53288371592",
                          @"com.kingsoft.powerword.6",
                          @"baidutranslate",
                          @"itranslate",
                          @"wx9b913299215a38f2",
                          @"googlemaps",
                          @"baidumap",
                          @"sosomap",
                          @"tantumap",
                          @"clover-imoney",
                          @"xCurrency",
                          @"booking",
                          @"agoda",
                          @"hotelsapp",
                          @"airbnb",
                          @"wx7df4b03946413415",
                          @"diditaxi",
                          @"uberx",
                          @"zuzuche",
                          @"huizuche",
                          @"hbcc",
                          @"gtgj",
                          @"ofoapp",
                          @"mobike",
                          @"cn.12306",
                          @"mybus",
                          @"wx3e388e8f02f38759",
                          @"doubanradio",
                          @"lizhifm",
                          @"iting",
                          @"qtfmp",
                          @"wx4787624ac8489f62",
                          @"zhihu",
                          @"zhihudaily",
                          @"kindle",
                          @"com.jianshu.Hugo",
                          @"evernote",
                          @"iReader",
                          @"dedaoapp",
                          @"bdwenku",
                          @"weread",
                          @"shuqireader",
                          @"qqreader",
                          @"lazyaudio",
                          @"lkjhgfddsa",
                          @"ZSSQ",
                          @"snssdk141",
                          @"yidianpro",
                          @"qdaily",
                          @"comIfeng3GifengNews",
                          @"qqnews",
                          @"sohunews",
                          @"newsapp",
                          @"QQquick57m68b",
                          @"qtt2016219",
                          @"sinanews",
                          @"com.infzm.Infzm",
                          @"bazaarinmcitech",
                          @"wxee3f84f8ba88e8f9",
                          @"caijingiphone",
                          @"cxweekly",
                          @"com.sogou.input",
                          @"orpheus",
                          @"lkjhgfddsa",
                          @"com.kuwo.kwmusic.kwmusicForKwsing",
                          @"kugouURL",
                          @"qqmusic",
                          @"baidumusic",
                          @"xiami",
                          @"wxb4cd572ca73fd239",
                          @"qmkege",
                          @"changba",
                          @"duitang",
                          @"lofter",
                          @"iliangcang",
                          @"wbmain",
                          @"zpm650",
                          @"lagouhr",
                          @"BossZP",
                          @"djapp",
                          @"meetyou.linggan",
                          @"wx4cba531f924ca13f",
                          @"wx32fed79accf146c7",
                          @"wxf3a0531700719f70",
                          @"wb1176522257",
                          @"photowonder",
                          @"wondercamera",
                          @"enlight",
                          @"mtxx",
                          @"b612cn",
                          @"faceu",
                          @"kwai",
                          @"line3rdp.com.Benqumark.KuaiMeiKuaiZhuang",
                          @"ttpicOpenAPI",
                          @"com.picsart.studio",
                          @"mtmv",
                          @"lkjhgfddsa",
                          @"ntesopen",
                          @"wyyktiphone",
                          @"mukewang",
                          @"lkjhgfddsa",
                          @"duolingo",
                          @"solar",
                          @"xtuonesuperfriday:",
                          @"lkjhgfddsa",
                          @"wxabcc987deb39fc2b:",
                          @"lkjhgfddsa",
                          @"Ape9b19bd0263cd",
                          @"askhomework",
                          @"ai.zuoye.app",
                          @"hdzy",
                          @"ksstory",
                          @"lkjhgfddsa",
                          @"com.shanbay.words",
                          @"bcz",
                          @"com.kingsoft.powerword.6",
                          @"lls",
                          @"wx6918ddf7681ee2d5",
                          @"cichang",
                          @"wcc",
                          @"lkjhgfddsa",
                          @"sdspapp",
                          @"youku",
                          @"bilibili",
                          @"pptv",
                          @"qiyi-iphone",
                          @"com.baofeng.play",
                          @"baiduvideoiphone",
                          @"sohuvideo-iphone",
                          @"tenvideo",
                          @"wx40f1ed0460d8cbf4",
                          @"imgotv",
                          @"lkjhgfddsa",
                          @"hanju",
                          @"wxd96a4a9856e9fac6",
                          @"awemesso",
                          @"hotsoonsso",
                          @"huajiao",
                          @"pandatv",
                          @"yykiwi",
                          @"douyutv",
                          @"yymobile",
                          @"peach1095977764",
                          @"wx6a1be9a606fae87c",
                          @"trivia",
                          @"fb737875599617717",
                          @"buka",
                          @"kuaikanmanhua",
                          @"comicreader",
                          @"YOLOTongZhuoGamePingpp",
                          @"bankabc",
                          @"wx2654d9155d70a468",
                          @"com.icbc.iphoneclient",
                          @"wx1cb534bb13ba3dbd",
                          @"bocom",
                          @"mdb",
                          @"spdbccc",
                          @"cmbmobilebank",
                          @"BOCMBCIZF",
                          @"cmblife",
                          @"com.icbc.iphoneEChannel",
                          @"paesuperbank",
                          @"FDMoney",
                          @"qzzb",
                          @"kdjz",
                          @"amihexin",
                          @"palifeapp",
                          @"jdmobile",
                          @"com.dgzq.zzb",
                          @"junrongdai",
                          @"dingtalk",
                          @"wxworkrelease",
                          @"maimaiback",
                          @"timopensdkapiV4",
                          @"camcard",
                          @"camscannerco",
                          @"neteasemail",
                          @"mailmaster",
                          @"mianfeijiaotongweizhang",
                          @"zcblbjjj",
                          @"tmri12123",
                          @"wx1a3bf9c3cf2769d3",
                          @"wxae514d26ad7d879d",
                          @"autohome",
                          @"rrc",
                          @"guazi",
                          @"jxedt",
                          @"jiakaobaodianxingui",
                          @"dxy-aspirin",
                          @"dxy-aspirinpro",
                          @"keep",
                          @"codoon",
                          @"widgetMifit",
                          @"boohee",
                          @"yuedongapp",
                          @"nikerunclub",
                          @"DamaiIphoneAAA",
                          @"ticketapp",
                          @"tbmovie",
                          @"meituanmovie",
                          @"qqsports",
                          @"zhibo8",
                          @"qielive",
                          @"pptvsports",
                          @"huputiyu",
                          @"soufunchat",
                          @"fdd",
                          @"openanjuke",
                          @"lianjiaapp",
                          @"eleme",
                          @"meituanwaimai",
                          @"bdwm",
                          @"xcfapp",
                          @"caipudaquanWidget",
                          @"babytree",
                          @"bbtime",
                          @"askmybaby",
                          @"cn.10086.app",
                          @"HappyAnimal3",
                          @"wx95a3a4d7c627e07d",];
        
        NSMutableString *res = [NSMutableString new];
        for(NSString *urlString in test) {
            BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[urlString stringByAppendingString:@"://"]]];
            if(canOpen) {
                [res appendString:@"1"];
            }else{
                [res appendString:@"0"];
            }
        }
        dispatch_async(dispatch_get_main_queue(),^{
            if (callBack) {
                callBack(res);
            }
        });
    });
}

-(BOOL)juageWXAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]?YES:NO;
}

-(BOOL)juageQQAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]?YES:NO;
}

-(BOOL)juageUCBrowserAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ucbrowser://"]]?YES:NO;
}

-(BOOL)juageBaiduMapAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]?YES:NO;
}

-(BOOL)juageTaobaoAppInstalled{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"taobao://"]]?YES:NO;
}

-(NSMutableString *)getChannel{
    BOOL ifQQInstalled = [sharedChannel juageQQAppInstalled];
    BOOL ifTaobaoInstalled = [sharedChannel juageTaobaoAppInstalled];
    BOOL ifWXInstalled = [sharedChannel juageWXAppInstalled];
    BOOL ifBaiduMapInstalled = [sharedChannel juageBaiduMapAppInstalled];
    BOOL ifUCBrowserInstalled = [sharedChannel juageUCBrowserAppInstalled];
    NSMutableString * channelToken = [NSMutableString stringWithString:@""];
    if (ifWXInstalled) {
        [channelToken appendString:@"1,"];
    }
    if (ifQQInstalled) {
        [channelToken appendString:@"2,"];
    }
    if (ifTaobaoInstalled) {
        [channelToken appendString:@"3,"];
    }
    if (ifUCBrowserInstalled) {
        [channelToken appendString:@"4,"];
    }
    if (ifBaiduMapInstalled) {
        [channelToken appendString:@"5,"];
    }
    if (channelToken.length) {
        [channelToken deleteCharactersInRange:NSMakeRange(channelToken.length-1, 1)];
    }
    return channelToken;
}
@end
