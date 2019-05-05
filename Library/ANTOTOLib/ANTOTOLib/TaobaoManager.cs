using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Security;

namespace ANTOTOLib
{
    public class TaobaoManager
    {
        public static string getSign()
        {
            string code = "";
            DateTime nowTime = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            code = FormsAuthentication.HashPasswordForStoringInConfigFile(FormsAuthentication.HashPasswordForStoringInConfigFile((ConvertDateMinTimeDouble(nowTime) + "1b46af52a8dcaa822b98b1be9d447bb2"), "MD5").ToLower(), "MD5").ToLower();
            code = System.Convert.ToBase64String(System.Text.Encoding.Default.GetBytes(code));
            return code;
        }

        public static int ConvertDateMinTimeDouble(System.DateTime time)
        {
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1)); return (int)(time - startTime).TotalMinutes;
        }

        public static void ItemSoldUpdate(int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            
        }

        public static void ItemSoldUpdateIncrement(int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();

        }

        public class TaobaoOrder
        {
            public string seller_nick { get; set; } //卖家昵称
            public string buyer_nick { get; set; } //买家昵称
            public string title { get; set; } //商品标题
            public string type { get; set; } //交易类型
            public string refund_status { get; set; } //退款状态.可选 值:WAIT_SELLER_AGREE(买家已经申请退款, 等待卖家同意), WAIT_BUYER_RETURN_GOODS(卖家已经同意退款, 等待 买家退货), WAIT_SELLER_CONFIRM_GOODS5(买家已经退货, 等待卖家确认收货), CLOSED(退款关闭), SUCCESS(退 款成功), SELLER_REFUSE_BUYER(卖家拒绝退款), NO_REFUND(没有退款)
            public DateTime? created { get; set; }//交易创建时间。格 式:yyyy-MM-dd HH:mm:ss
            public string iid { get; set; } //商品Item的id.可以通过 taobao.item.get获取详细的商品Item的信息
            public string price { get; set; } //商品价格。精确到2位小数; 单 位:元。如:200.07，表示:200元7分
            public string pic_path { get; set; } //商品图片的绝对路径
            public int? num { get; set; } //购买数量。取值范围:大于零的 整数
            public string tid { get; set; } //子订单id
            public string buyer_message { get; set; } //买家留言
            public string sid { get; set; } //物流Shipping的id
            public string shipping_type { get; set; }//创建交易时的物流方式（交易完 成前，物流方式有可能改变，但tc里的这个字段一直不变）。可选值:free(卖家承担运费),post(平邮),express(快 递),ems(EMS),virtual (虚拟物品)
            public string alipay_no { get; set; } //支付宝交易号
            public string payment { get; set; } //实付金额。精确到2位小数;单 位:元。如:200.07，表示:200元7分
            public string discount_fee { get; set; } //系统优惠金额。精确到2位小 数; 单位:元。如:200.07，表示:200元7分
            public string adjust_fee { get; set; } //卖家优惠金额.格式 为:1.01; 单位:元;精确到小数点后两位.
            public string snapshot_url { get; set; } //订单快照URL
            public string status { get; set; } //订单状态.可选 值:WAIT_BUYER_PAY(等待买家付款), WAIT_BUYER_CONFIRM_GOODS(卖家已发 货), WAIT_SELLER_SEND_GOODS(买家已付款), TRADE_FINISHED(交易成功), TRADE_CLOSED(交易关 闭), TRADE_CLOSED_BY_TAOBAO(交易被淘宝关闭), TRADE_NO_CREATE_PAY(没有创建外部交易(支付宝交 易)),OTHER(其他状态)
            public bool? seller_rate { get; set; } //卖家是否已评价。可选 值:true(已评价),false(未评价)
            public bool? buyer_rate { get; set; } //买家是否已评价。可选 值:true(已评价),false(未评价)
            public string buyer_memo { get; set; } //买家备注
            public string seller_memo { get; set; } //卖家备注
            public DateTime? pay_time { get; set; } //付款时间。格式:yyyy- MM-dd HH:mm:ss
            public DateTime? end_time { get; set; } //交易成功时间(更新交易状态为 成功的同时更新)/确认收货时间。格式:yyyy-MM-dd HH:mm:ss
            public DateTime? modified { get; set; } //交易修改时间(用户对订单的操 作会更新此字段)。格式:yyyy-MM-dd HH:mm:ss
            public string buyer_obtain_point_fee { get; set; } //买家获得积分,返点的积分。格 式:100; 单位:个
            public string point_fee { get; set; } //买家使用积分。格式:100; 单位:个.
            public string real_point_fee { get; set; } //买家实际使用积分。格 式:100; 单位:个.
            public string total_fee { get; set; } //应付金额。精确到2位小数;单 位:元。如:200.07，表示:200元7分
            public string post_fee { get; set; } //邮费。精确到2位小数;单位: 元。如:200.07，表示:200元7分
            public string buyer_alipay_no { get; set; } //买家支付宝账号
            public string receiver_name { get; set; } //收货人的姓名
            public string receiver_state { get; set; } //收货人的所在省份
            public string receiver_city { get; set; } //收货人的所在城市
            public string receiver_district { get; set; } //收货人的所在地区
            public string receiver_address { get; set; } //收货人的详细地址
            public string receiver_zip { get; set; } //收货人的邮编
            public string receiver_mobile { get; set; } //收货人的手机号码
            public string receiver_phone { get; set; } //收货人的电话号码
            public DateTime? consign_time { get; set; } //卖家发货时间。格 式:yyyy-MM-dd HH:mm:ss
            public string buyer_email { get; set; } //买家Email
            public string commission_fee { get; set; } //交易佣金。精确到2位小数;单 位:元。如:200.07，表示:200元7分
            public string seller_alipay_no { get; set; } //卖家支付宝账号
            public string seller_mobile { get; set; } //卖家手机
            public string seller_phone { get; set; } //卖家电话
            public string seller_name { get; set; } //卖家姓名
            public string seller_email { get; set; } //卖家Email
            public string available_confirm_fee { get; set; } //能够确认收货的实付款。精确到 2位小数;单位:元。如:200.07，表示:200元7分
            public string has_postFee { get; set; } //是否包含邮费。与 available_confirm_fee同时使用。可选值:true(包含),false(不包含)
            public string received_payment { get; set; } //卖家实际收到的支付宝打款金 额。精确到2位小数;单位:元。如:200.07，表示:200元7分
            public string cod_fee { get; set; } //货到付款服务费。精确到2位小 数; 单位:元。如:200.07，表示:200元7分
            public DateTime? timeout_action_time { get; set; } //订单超时到期时间。格 式:yyyy-MM-dd HH:mm:ss
            public List<TaobaoOrderDetail> orders { get; set; } //订单列表
            public string sku_id { get; set; } //商品的最小属性单元Sku的 id.可以通过APItaobao.item.sku.get获取详细的Sku信息
            public string sku_properties_name { get; set; } //sku的值。如：机身颜色:黑 色; 手机套餐:官方标配
            public string item_meal_name { get; set; } //套餐的值。如：M8原装电池: 便携支架:M8专用座充:莫凡保护袋
            public string outer_iid { get; set; } //商家外部编码(可与商家外部系 统对接).外部商家自己定义的商品Item的id,可以通过APITaobao.fullitems.get获取 商品的Item的信息
            public string outer_sku_id { get; set; } //外部网店自己定义的Skuid
        }

        public class TaobaoOrderDetail
        {
            public string item_meal_name { get; set; }  //M8原装电池:便携支架:M8专用座充:莫凡保护袋 套餐的值。如：M8原装电池:便携支架:M8专用座充:莫凡保护袋
            public string pic_path { get; set; }   //http://img08.taobao.net/bao/uploaded/i8/T1jVXXXePbXXaoPB6a_091917.jpg	商品图片的绝对路径
            public string seller_nick { get; set; }  //麦包包 卖家昵称
            public string buyer_nick { get; set; }  //碎银子 买家昵称
            public string refund_status { get; set; } //SUCCESS(退款成功)   退款状态。退款状态。可选值 WAIT_SELLER_AGREE(买家已经申请退款，等待卖家同意) WAIT_BUYER_RETURN_GOODS(卖家已经同意退款，等待买家退货) WAIT_SELLER_CONFIRM_GOODS(买家已经退货，等待卖家确认收货) SELLER_REFUSE_BUYER(卖家拒绝退款) CLOSED(退款关闭) SUCCESS(退款成功)
            public string outer_iid { get; set; }	//152e442aefe88dd41cb0879232c0dcb0 商家外部编码(可与商家外部系统对接)。外部商家自己定义的商品Item的id，可以通过taobao.items.custom.get获取商品的Item的信息
            public string snapshot_url { get; set; } //T1mURbXopZXXXe3rLI.1257513712679_snap 订单快照URL
            public string snapshot { get; set; } // 自定义值 订单快照详细信息
            public DateTime? timeout_action_time { get; set; }	//2000-01-01 00:00:00	订单超时到期时间。格式:yyyy-MM-dd HH:mm:ss
            public bool? buyer_rate { get; set; } //买家是否已评价。可选值：true(已评价)，false(未评价)
            public bool? seller_rate { get; set; } //卖家是否已评价。可选值：true(已评价)，false(未评价)
            public string seller_type { get; set; }//（商城商家）	卖家类型，可选值为：B（商城商家），C（普通卖家）
            public int? cid {get;set;}	//交易商品对应的类目ID
            public string sub_order_tax_fee { get; set; }	//0	天猫国际官网直供子订单关税税费
            public string sub_order_tax_rate { get; set; }	//0	天猫国际官网直供子订单关税税率
            public string estimate_con_time { get; set; } //demo    子订单预计发货时间
            public int? oid { get; set; }	//2231958349	子订单编号
            public string status { get; set; }  //TRADE_NO_CREATE_PAY 订单状态（请关注此状态，如果为TRADE_CLOSED_BY_TAOBAO状态，则不要对此订单进行发货，切记啊！）。可选值:
                                                //TRADE_NO_CREATE_PAY(没有创建支付宝交易)
                                                //WAIT_BUYER_PAY(等待买家付款)
                                                //WAIT_SELLER_SEND_GOODS(等待卖家发货, 即:买家已付款)
                                                //WAIT_BUYER_CONFIRM_GOODS(等待买家确认收货, 即:卖家已发货)
                                                //TRADE_BUYER_SIGNED(买家已签收, 货到付款专用)
                                                //TRADE_FINISHED(交易成功)
                                                //TRADE_CLOSED(付款以后用户退款成功，交易自动关闭)
                                                //TRADE_CLOSED_BY_TAOBAO(付款以前，卖家或买家主动关闭交易)
                                                //PAY_PENDING(国际信用卡支付付款确认中)
            public string title { get; set; }  //山寨版测试机器 商品标题
            public string type { get; set; } // 直冲 交易类型
            public string iid { get; set; } //152e442aefe88dd41cb0879232c0dcb0 商品的字符串编号(注意：iid近期即将废弃，请用num_iid参数)
            public string price { get; set; }	//200.07	商品价格。精确到2位小数;单位:元。如:200.07，表示:200元7分
            public int? num_iid { get; set; }	//2342344	商品数字ID
            public int? item_meal_id { get; set; }	//2564854632	套餐ID
            public string sku_id { get; set; }	//5937146	商品的最小库存单位Sku的id.可以通过taobao.item.sku.get获取详细的Sku信息
            public int? num { get; set; }   //1	购买数量。取值范围:大于零的整数
            public string outer_sku_id { get; set; }	//81893848	外部网店自己定义的Sku编号
            public string order_from { get; set; } //jhs 子订单来源,如jhs(聚划算)、taobao(淘宝)、wap(无线)
            public string total_fee { get; set; }	//200.07	应付金额（商品价格* 商品数量 + 手工调整金额 - 子订单级订单优惠金额）。精确到2位小数;单位:元。如:200.07，表示:200元7分
            public string payment { get; set; }	//200.07	子订单实付金额。精确到2位小数，单位:元。如:200.07，表示:200元7分。对于多子订单的交易，计算公式如下：payment = price* num + adjust_fee - discount_fee ；单子订单交易，payment与主订单的payment一致，对于退款成功的子订单，由于主订单的优惠分摊金额，会造成该字段可能不为0.00元。建议使用退款前的实付金额减去退款单中的实际退款金额计算。
            public string discount_fee { get; set; }	//200.07	子订单级订单优惠金额。精确到2位小数;单位:元。如:200.07，表示:200元7分
            public string adjust_fee { get; set; }	//1.01	手工调整金额.格式为:1.01;单位:元;精确到小数点后两位.
            public DateTime? modified { get; set; }	//2000-01-01 00:00:00	订单修改时间，目前只有taobao.trade.ordersku.update会返回此字段。
            public string sku_properties_name { get; set; }  //颜色:桔色;尺码:M SKU的值。如：机身颜色:黑色;手机套餐:官方标配
            public string refund_id { get; set; }	//2231958349	最近退款ID
            public bool? is_oversold { get; set; }	//是否超卖
            public bool? is_service_order { get; set; }	//是否是服务订单，是返回true，否返回false。
            public DateTime? end_time { get; set; }	//2012-04-07 00:00:00	子订单的交易结束时间说明：子订单有单独的结束时间，与主订单的结束时间可能有所不同，在有退款发起的时候或者是主订单分阶段付款的时候，子订单的结束时间会早于主订单的结束时间，所以开放这个字段便于订单结束状态的判断
            public string consign_time { get; set; }	//2013-01-13 15:23:00	子订单发货时间，当卖家对订单进行了多次发货，子订单的发货时间和主订单的发货时间可能不一样了，那么就需要以子订单的时间为准。（没有进行多次发货的订单，主订单的发货时间和子订单的发货时间都一样）
            
            public string shipping_type { get; set; }   //子订单的运送方式（卖家对订单进行多次发货之后，一个主订单下的子订单的运送方式可能不同，用order.shipping_type来区分子订单的运送方式）
            public int? bind_oid { get; set; }	//23194074143138	捆绑的子订单号，表示该子订单要和捆绑的子订单一起发货，用于卖家子订单捆绑发货
            public string logistics_company { get; set; } //顺风快递    子订单发货的快递公司名称
            public string invoice_no { get; set; }	//子订单所在包裹的运单号
            public bool is_daixiao { get; set; } //表示订单交易是否含有对应的代销采购单。如果该订单中存在一个对应的代销采购单，那么该值为true；反之，该值为false。
            public string divide_order_fee { get; set; } //分摊之后的实付金额
            public string part_mjz_discount { get; set; }	//21.00	优惠分摊
            public string ticket_outer_id { get; set; }	//123456abcd 对应门票有效期的外部id
            public string ticket_expdate_key { get; set; }	//100FFFFFF02374020000002001020304000A 门票有效期的key
            public string store_code { get; set; }  //南京QDHEWL-0004	发货的仓库编码
            public bool? is_www { get; set; } //子订单是否是www订单
            public string tmser_spu_code { get; set; } //家装干支装服务 支持家装类物流的类型
            public string bind_oids { get; set; }	//193741211090019,193741211080019	bind_oid字段的升级，支持返回绑定的多个子订单，多个子订单以半角逗号分隔
            public string zhengji_status { get; set; }	//1	征集预售订单征集状态：1（征集中），2（征集成功），3（征集失败）
            public string md_qualification { get; set; }  //true_免单原因 免单资格属性
            public string md_fee { get; set; }	//999	免单金额
            public string customization { get; set; }   //{ "itemId":"2100753308662","pic":[{"id":1,"url":"//img.alicdn.com/imgextra/i1/664681545/TB2tYURjpXXXXadXpXXXXXXXXXX_!!664681545.jpg"}],"skuId":"0","text":[{"content":"oreo","id":1}]}定制信息
            public string inv_type { get; set; } //6	库存类型：6为在途
            public bool is_sh_ship { get; set; } //是否发货
            public string shipper { get; set; } //cn  仓储信息
            public string f_type { get; set; } //jsd 订单履行类型，如喵鲜生极速达（jsd）
            public string f_status { get; set; }  //分单完成 订单履行状态，如喵鲜生极速达：分单完成
            public string f_term { get; set; } //storeId 单履行内容，如喵鲜生极速达：storeId,phone
            public string o2o_et_order_id { get; set; }
            public string combo_id { get; set; }	//1923423423	天猫搭配宝
            public string assembly_rela { get; set; }	//100293929394324	主商品订单id
            public string assembly_price { get; set; }	//30000	价格
            public string assembly_item { get; set; }	//1234,234234	assemblyItem
            public string sub_order_tax_promotion_fee { get; set; } //	0	天猫国际子订单计税优惠金额
            public string cl_down_payment { get; set; }	//1000	clDownPayment
            public string cl_down_payment_ratio { get; set; }	//1000	clDownPaymentRatio
            public string cl_month_payment { get; set; }	//1000	clMonthPayment
            public string cl_tail_payment { get; set; }	//1000	clTailPayment
            public string cl_installment_num { get; set; }	//1000	clInstallmentNum
            public string cal_penalty { get; set; }	//1000	calPenalty
            public string cl_service_fee { get; set; }	//1000	clServiceFee
            public string cl_car_taker { get; set; }	//1000	clCarTaker
            public string cl_car_taker_phone { get; set; }	//1000	clCarTakerPhone
            public string cl_car_taker_i_d_num { get; set; }	//1000	clCarTakerIDNum
            public string cl_car_taker_id_num { get; set; }	//1000	clCarTakerIDNum
            public string down_payment { get; set; }	//1000	downPayment
            public string down_payment_ratio { get; set; }	//1000	downPaymentRatio
            public string month_payment { get; set; }	//1000	monthPayment
            public string tail_payment { get; set; }	//1000	tailPayment
            public string installment_num { get; set; }	//12	installmentNum
            public string penalty { get; set; }	//1000	penalty
            public string service_fee { get; set; }	//1000	serviceFee
            public string car_taker { get; set; } //张三  carTaker
            public string car_taker_phone { get; set; }	//12345678901	carTakerPhone
            public string car_taker_id_num { get; set; }	//123	carTakerIDNum
            public string car_store_code { get; set; }	//123	carStoreCode
            public string car_store_name { get; set; } //汽车门店    carStoreName
            public string out_unique_id { get; set; }	//123	outUniqueId
            public string ws_bank_apply_no { get; set; }	//123	wsBankApplyNo
            public string car_taker_id { get; set; }	//123	carTakerID
            public string oid_str { get; set; }	//123	oidStr
            public int? fqg_num { get; set; }	//12	花呗分期期数
            public bool? is_fqg_s_fee { get; set; }	//是否商家承担手续费
            public bool? tax_free { get; set; }	//天猫国际订单是否包税
            public string tax_coupon_discount { get; set; }	//0	天猫国际订单包税金额
            public string recharge_fee { get; set; }	//1000	个人充值红包金额
            public string platform_subsidy_fee { get; set; }	//100.00	platformSubsidyFee
            public string nr_reduce_inv_fail { get; set; }	//1	nrReduceInvFail
            public string nr_outer_iid { get; set; }	//2983778187	新零售商家端商品唯一编号
            public string bind_oids_all_status { get; set; }	//193741211090019,193741211080019	bind_oids字段的升级，在交易成功和交易关闭状态下也能获取到，支持返回绑定的多个子订单，多个子订单以半角逗号分隔
        }
        


    }
}
