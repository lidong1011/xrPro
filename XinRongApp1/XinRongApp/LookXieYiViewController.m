//
//  LookXieYiViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/9.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "LookXieYiViewController.h"

@interface LookXieYiViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation LookXieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户协议";
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _textView.text = @"【注意】欢迎您进入新融网， 本网站由湖南衡阳新润资本民间投资服务有限公司负责运营。\n\
    \n\
    请您（下列简称为“用户”）仔细阅读以下全部内容。如用户不同意本服务条款任意内容，请勿注册或使用新融网服务。如用户通过进入注册程序并勾选“同意新融注册协议”，即表示用户与新融网已达成协议，自愿接受本服务条款的所有内容。此后，用户不得以未阅读本服务条款内容作任何形式的抗辩。\n\
    一、使用限制\n\
    \n\
    1.1 本网站只接受持有中国大陆（不包括香港特区、澳门特区及台湾地区）有效身份证的18周岁以上的具有完全民事行为能力的自然人成为本网站用户。如您不符合资格，请勿注册。本网站保留随时中止或终止您用户资格的权利。\n\
    \n\
    1.2 您有义务在注册时提供自己的真实资料。本服务协议不涉及您与本网站的其他用户之间因使用本网站而产生的法律关系及法律纠纷。\n\
    \n\
    1.3 您注册成功后，该注册名及密码仅供注册者本人使用，注册成功后应妥善保管您的用户名和密码。您不得将本网站的用户名及密码转让给第三方或者授权给第三方使用。您的用户名和密码登录本网站后在本网站的一切行为均视为您本人作出，并由您承担相应的法律后果。\n\
    \n\
    1.4 您承诺合法使用本网站提供的信息及服务。禁止在本网站从事任何违反中华人民共和国现行的法律、法规、规章和规范性文件的行为或者任何未经授权使用本网站的行为，如擅自进入本网站的未公开的系统、不正当的使用密码和网站的任何内容等。\n\
    \n\
    1.5 本网站中的全部内容的版权均属于本网站所有，该内容包括但不限于文本、数据、文章、设计、源代码、软件、图片、照片及其他全部信息。网站内容受中华人民共和国法律、法规和相关规定的保护。未经本网站事先书面同意，您承诺不以任何方式、不以任何形式复制、模仿、传播、出版、公布、展示网站内容，包括但不限于电子的、机械的、复印的、录音录像的方式和形式等。未经本网站书面同意，您亦不得将本网站包含的资料等任何内容镜像到任何其他网站或者服务器。任何未经授权对网站内容的使用均属于违法行为，本网站有权追究您的法律责任。\n\
    二、个人信息的使用及隐私保护\n\
    \n\
    2.1 您在注册时应提供自己的真实资料，并保证诸如电子邮件地址、联系电话、联系地址、邮政编码等内容的有效性、安全性和及时更新，以便本网站为您提供服务，与您进行及时、有效的联系。您应完全独自承担因通过这些联系方式无法与您取得联系而导致的您在使用本服务过程中遭受的任何损失或增加任何费用等不利后果。\n\
    \n\
    2.2 本网站对于您提供的、自行收集到的、经认证的个人信息将按照本协议及有关规则予以保护、使用或者披露。\n\
    \n\
    2.3 您同意本网站可以自行或通过合作的第三方机构对您提交或本网站搜集的用户信息（包括但不限于您的个人身份证信息等）进和留存等操作。\n\
    \n\
    2.4 您使用本网站服务进行交易时，您即同意本网站将您的个人信息，包括但不限于真实姓名、联系方式、信用状况等必要的个人信息和交易信息披露给与您交易的另一方或本网站的合作机构（仅限于本网站为完成拟向您提供的服务而合作的机构）。\n\
    \n\
    2.5 本网站有义务根据有关法律的规定向司法机关和政府部门提供您的个人资料。在您未能按照与本协议、本网站有关规则履行自己应尽的义务时，本网站有权根据自己的判断、有关协议和规则、与该笔交易有关的其他用户的合理请求或者司法部门要求向其提供相关资料，由此产生的法律后果，本网站不承担任何责任。\n\
    \n\
    2.6 在本网站提供的交易活动中，除您已向法院起诉其他用户在本网站活动中的违约行为外，您无权要求本网站提供其他用户的个人资料。\n\
    \n\
    2.7 对于您从本网站获得的其他用户的个人资料，不得公开、披露或再次向他人提供，如因您公开、披露他人资料给他人造成损害的，一切法律后果由您本人承担，本网站不承担任何责任。\n\
    三、服务、资金管理\n\
    \n\
    3.1 基于本网站运行和交易安全的需要，本网站可以暂时停止提供、限制或改变本网站服务的部分功能，或提供新的功能。在任何功能减少、增加或者变化时，只要您仍然使用本网站的服务，表示您仍然同意本协议或者变更后的协议。\n\
    \n\
    3.2 您同意本网站服务流程所确认的交易状态是本网站为您进行相关交易或操作的明确指令。本网站有权按相关指令依据本协议或有关规则对相关事项进行处理。因您未能及时对交易状态进行修改或确认或未能提交相关申请所引起的任何纠纷或损失由您本人负责，本网站不承担任何责任。\n\
    \n\
    3.3 您同意本网站制定、修改、公布交易规则、收费标准等。包括理财规则和费用、贷款规则和费用、投资积分规则、债权转让规则和费用、充值提现费用、利率等。具体规则请参照各个部分的单独规定。并确定您在进行交易前已经仔细阅读和理解该规则。如不同意该规则或费用标准请立即停止交易行为。\n\
    \n\
    3.4 您保证并承诺您通过本网站平台进行交易的资金来源合法。您同意，本公司有权按照公安机关、检察机关、法院等司法机关、行政机关、军事机关的要求协助或当您的账户有可能被盗用时对您的账户及资金等进行查询、冻结或扣划等操作。\n\
    四、涉及第三方\n\
    \n\
    4.1 您同意本网站使用第三方机构作为资金托管平台，主要包括但不限于：资金的充值、提现、代收、代付、查询等。您确定使用前已经通过有关页面详细了解第三方机构的具体操作规则或说明。\n\
    \n\
    4.2 您应按照第三方机构网站的服务协议使用第三方网站。第三方网站的内容、产品、广告和其他任何信息均与本网站无关，您在第三方网站上从事的各种活动由您本人自行判断风险并承担责任，与本网站无关。\n\
    \n\
    4.3 由于第三方机构或金融机构的原因（如仅在工作日进行资金代扣及划转的现状等各种原因）造成的不利后果（如资金不能及时到账），本网站不承担任何责任，也不承担由此产生的利息、货币贬值等损失。您与第三方机构之间产生的费用支付事项与本网站无关。\n\
    五、责任限制\n\
    \n\
    5.1 本网站提供的任何信息仅供参考。本网站不对因本网站资料全部或部分内容产生的或因依赖该资料而引致的损失承担任何责任，也不对因本网站提供的资料不充分、不完整或未能提供特定资料产生的损失承担任何责任。\n\
    \n\
    5.2 本网站如因系统维护或升级而需暂停服务时，将事先公告。若因线路及非本网站控制范围内的硬件故障或其它不可抗力而导致的暂停服务，对于暂停服务期间造成的一切不便与损失，本网站不负任何责任。\n\
    \n\
    5.3 如第三方通知我司网站存在侵权信息、材料，本网站将在核实有关情况后，及时对该信息、材料采取删除、屏蔽、断开链接等必要措施。本网站尽到上述义务后，不再承担任何责任。\n\
    六、网站内容监测\n\
    \n\
    6.1 您确认并同意本网站对网站内容进行监测，同意本网站有权根据法律、法规、政府要求透露、修改或者删除必要的、不合适的信息，以便更好地运营本网站并保护自身及本网站的其他用户的合法权益。\n\
    \n\
    6.2 本网站禁止任何人在使用本网站提供的服务时，以任何形式上传、发布或传播任何包含有诽谤他人、污秽语言、任何损害他人利益或违反法律、法规规定的资料或信息。\n\
    \n\
    6.3 涉及到网站用户对他人或其他机构进行各种评价的，本网站对其评价内容不承担任何责任。\n\
    七、协议的终止、账户的暂停、恢复和注销\n\
    \n\
    7.1 除非本网站终止本协议或者您申请终止本协议且经本网站同意，否则本协议始终有效。您和网站的终止行为均不能免除您根据本服务协议或在本网站生成的其他协议项下的还未履行完毕的义务。\n\
    \n\
    7.2 当您的账户出现可能存在异常情况下，如有可能被人冒用、盗用账户、密码等。本网站有权不通知您而对您的账号使用临时暂停等措施。待与您共同排除异常情况后恢复您账号的正常使用。在此期间由此产生的任何后果，本网站不承担任何责任。\n\
    \n\
    7.3 您有权向本网站申请暂停使用和恢复使用自己的账号。但是您在申请时必须有正当理由，否则本网站对该申请不予准许。在此期间由此产生的任何后果，本网站不承担任何责任。\n\
    \n\
    7.4 您有权申请注销自己在本网站的账号，在出现下列情况时，您可申请注销本网站账号：\n\
    \n\
    7.4.1 永久性停止使用本网站账号，与本网站的各项权利义务均履行完毕；\n\
    \n\
    7.4.2 居民身份发生变化，如移民导致的国籍变化，与本网站的各项权利义务均履行完毕；\n\
    \n\
    7.4.3 会员死亡或被宣告死亡的，其继承人有权申请注销账号；\n\
    \n\
    7.4.4 其他原因需要注销账号的。\n\
    八、纠纷的处理\n\
    \n\
    8.1 由于您违反本协议或任何法律、法规或侵害第三方的权益而引起第三方对本网站提出的任何形式的索赔、要求、诉讼。本网站有权向您追偿相关损失，包括但不限于本网站法律费用、名誉损失、及向第三方支付的补偿金等。\n\
    \n\
    8.2 因本站提供服务所产生的争议均适用中华人民共和国法律，并由本网站住所地人民法院管辖。\n\
    九、服务的变更或中止\n\
    \n\
    新融网始终在不断变更和改进服务。新融网可能会增加或删除功能，也可能暂停或彻底停止某项服务。用户同意新融网有权行使上述权利且不需对用户或第三方承担任何责任。\n\
    十、其他\n\
    \n\
    9.1 在本网站的某些部分或页面中可能存在除本协议以外的单独的附加服务条款，您在使用相关服务前有义务仔细阅读和理解该协议中的条款，当这些条款存在冲突时，在该些部分和页面中附加条款优先适用。\n\
    \n\
    9.2 若本协议的部分条款被认定为无效或者无法实施时，不影响本协议中的其他条款的效力。\n\
";
    _textView.backgroundColor = KLColor(246, 246, 246);
    [self.view addSubview:_textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
