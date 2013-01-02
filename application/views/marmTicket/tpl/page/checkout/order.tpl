[{capture append="oxidBlock_content"}]

    [{block name="checkout_order_errors"}]
        [{ if $oView->isConfirmAGBActive() && $oView->isConfirmAGBError() == 1 }]
            [{include file="message/error.tpl" statusMessage="PAGE_CHECKOUT_ORDER_READANDCONFIRMTERMS"|oxmultilangassign }]
        [{/if}]
        [{assign var="iError" value=$oView->getAddressError() }]
        [{ if $iError == 1}]
           [{include file="message/error.tpl" statusMessage="ERROR_DELIVERY_ADDRESS_WAS_CHANGED_DURING_CHECKOUT"|oxmultilangassign }]
        [{ /if}]
    [{/block}]

    [{block name="checkout_order_main"}]
        [{if !$oView->showOrderButtonOnTop()}]
            <div class="lineBox clear">
                <span class="title">[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_TITLE2" }]</span>
            </div>
        [{/if}]

        [{block name="checkout_order_details"}]
            [{ if !$oxcmp_basket->getProductsCount()  }]
                [{block name="checkout_order_emptyshippingcart"}]
                <div class="status corners error">[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_BASKETEMPTY" }]</div>
                [{/block}]
            [{else}]
                [{assign var="currency" value=$oView->getActCurrency() }]

                [{if $oView->isLowOrderPrice()}]
                    [{block name="checkout_order_loworderprice_top"}]
                        <div>[{ oxmultilang ident="MIN_ORDER_PRICE" }] [{ $oView->getMinOrderPrice() }] [{ $currency->sign }]</div>
                    [{/block}]
                [{else}]

                    <div id="orderAgbTop">
                        <form action="[{ $oViewConf->getSslSelfLink() }]" method="post" id="orderConfirmAgbTop">
                            [{ $oViewConf->getHiddenSid() }]
                            [{ $oViewConf->getNavFormParams() }]
                            <input type="hidden" name="cl" value="order">
                            <input type="hidden" name="fnc" value="[{$oView->getExecuteFnc()}]">
                            <input type="hidden" name="challenge" value="[{$challenge}]">
                            <input type="hidden" name="sDeliveryAddressMD5" value="[{$oView->getDeliveryAddressMD5()}]">
                            <div class="agb">
                                [{if $oView->isActive('PsLogin') }]
                                    <input type="hidden" name="ord_agb" value="1">
                                [{else}]
                                    [{if $oView->isConfirmAGBActive()}]
                                        [{oxifcontent ident="oxrighttocancellegend" object="oContent"}]
                                            <h3 class="section">
                                                <strong>[{ $oContent->oxcontents__oxtitle->value }]</strong>
                                            </h3>
                                            <input type="hidden" name="ord_agb" value="0">
                                            <input id="checkAgbTop" class="checkbox" type="checkbox" name="ord_agb" value="1">
                                            [{ $oContent->oxcontents__oxcontent->value }]
                                        [{/oxifcontent}]
                                    [{else}]
                                        [{oxifcontent ident="oxrighttocancellegend2" object="oContent"}]
                                            <h3 class="section">
                                                <strong>[{ $oContent->oxcontents__oxtitle->value }]</strong>
                                            </h3>
                                            <input type="hidden" name="ord_agb" value="1">
                                            [{ $oContent->oxcontents__oxcontent->value }]
                                        [{/oxifcontent}]
                                    [{/if}]
                                [{/if}]
                            </div>

                            [{oxscript add="$('#checkAgbTop').click(function(){ $('input[name=ord_agb]').val( parseInt($('input[name=ord_agb]').val()) ^ 1);});"}]

                            [{if $oView->showOrderButtonOnTop()}]
                                <div class="lineBox clear">
                                    <a href="[{ oxgetseourl ident=$oViewConf->getPaymentLink() }]" class="prevStep submitButton largeButton">[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_BACKSTEP" }]</a>
                                    <button type="submit" class="submitButton nextStep largeButton">[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_SUBMITORDER" }]</button>
                                </div>
                            [{/if}]
                        </form>
                    </div>
                [{/if}]

                [{block name="checkout_order_address"}]
                    <div id="orderAddress">
                        <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
                            <h3 class="section">
                            <strong>[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_ADDRESSES" }]</strong>
                            [{ $oViewConf->getHiddenSid() }]
                            <input type="hidden" name="cl" value="user">
                            <input type="hidden" name="fnc" value="">
                            <button type="submit" class="submitButton largeButton">[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_MODIFYADDRESS" }]</button>
                            </h3>
                        </form>
                        <dl>
                            <dt>[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_BILLINGADDRESS" }]</dt>
                            <dd>
                                [{include file="widget/address/billing_address.tpl"}]
                            </dd>
                        </dl>
                        [{assign var="oDelAdress" value=$oView->getDelAddress() }]
                        [{if $oDelAdress }]
                        <dl class="shippingAddress">
                            <dt>[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_SHIPPINGADDRESS" }]</dt>
                            <dd>
                                [{include file="widget/address/shipping_address.tpl" delivadr=$oDelAdress}]
                            </dd>
                        </dl>
                        [{/if}]

                        [{if $oView->getOrderRemark() }]
                            <dl class="orderRemarks">
                                <dt>Ihre Tickets werden für folgende Teilnehmer registriert:</dt>
                                <dd>
                                    [{*assign var="aVisitorData" value=$oxcmp_basket->getVisitorData()*}]
                                    [{foreach from=$oxcmp_basket->getVisitorData() item="visitor" key="number"}]
                                        <div class="visitorshortview">
                                            <strong>[{$number-1}]. Teilnemer</strong><br />
                                            <span>Name:</span>[{$visitor.fname}] [{$visitor.lname}]<br />
                                            <span>Twitter:</span>[{$visitor.twitter}]<br />
                                            <span>Position:</span>[{$visitor.position}]<br />
                                            <span>T-Shirt:</span>[{$visitor.tshirt}]<br />
                                        </div>
                                    [{/foreach}]
                                <div class="clear" style="float:left; width:100%">
                                      <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
                                              <br />
                                              [{ $oViewConf->getHiddenSid() }]
                                              <input type="hidden" name="cl" value="basket">
                                              <input type="hidden" name="fnc" value="">
                                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" class="submitButton largeButton">[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_MODIFY4" }]</button>

                                      </form>
                                  </div>
                                </dd>
                            </dl>
                        [{/if}]
                    </div>
                    <div style="clear:both;"></div>
                [{/block}]

                [{block name="shippingAndPayment"}]
                    <div id="orderPayment">
                        <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
                            <h3 class="section">
                                <strong>[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_PAYMENTMETHOD" }]</strong>
                                [{ $oViewConf->getHiddenSid() }]
                                <input type="hidden" name="cl" value="payment">
                                <input type="hidden" name="fnc" value="">
                                <button type="submit" class="submitButton largeButton">[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_MODIFY3" }]</button>
                            </h3>
                        </form>
                        [{assign var="payment" value=$oView->getPayment() }]
                        [{ $payment->oxpayments__oxdesc->value }]
                    </div>
                [{/block}]

                <div id="orderEditCart">
                    <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
                        <h3 class="section">
                            <strong>[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_BASKET" }]</strong>
                            [{ $oViewConf->getHiddenSid() }]
                            <input type="hidden" name="cl" value="start">
                            <input type="hidden" name="fnc" value="">
                            <button type="submit" class="submitButton largeButton">[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_MODIFY4" }]</button>
                        </h3>
                    </form>
                </div>

                [{block name="order_basket"}]
                    <div class="lineBox">
                        [{include file="page/checkout/inc/basketcontents.tpl" editable=false}]
                    </div>
                [{/block}]

                [{if $oView->isLowOrderPrice() }]
                    [{block name="checkout_order_loworderprice_bottom"}]
                        <div class="lineBox clear">
                            <div>[{ oxmultilang ident="MIN_ORDER_PRICE" }] [{ $oView->getMinOrderPrice() }] [{ $currency->sign }]</div>
                        </div>
                    [{/block}]
                [{else}]
                    [{block name="checkout_order_btn_confirm_bottom"}]
                        <form action="[{ $oViewConf->getSslSelfLink() }]" method="post" id="orderConfirmAgbBottom">
                            [{ $oViewConf->getHiddenSid() }]
                            [{ $oViewConf->getNavFormParams() }]
                            <input type="hidden" name="cl" value="order">
                            <input type="hidden" name="fnc" value="[{$oView->getExecuteFnc()}]">
                            <input type="hidden" name="challenge" value="[{$challenge}]">
                            <input type="hidden" name="sDeliveryAddressMD5" value="[{$oView->getDeliveryAddressMD5()}]">

                            <div class="agb">
                                [{if $oView->isActive('PsLogin') }]
                                    <input type="hidden" name="ord_agb" value="1">
                                [{else}]
                                    [{if $oView->isConfirmAGBActive()}]
                                            <input type="hidden" name="ord_agb" value="0">
                                    [{/if}]
                                [{/if}]
                            </div>

                            <div class="lineBox clear">
                                <a href="[{ oxgetseourl ident=$oViewConf->getPaymentLink() }]" class="prevStep submitButton largeButton">[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_BACKSTEP" }]</a>
                                <button type="submit" class="submitButton nextStep largeButton">[{ oxmultilang ident="PAGE_CHECKOUT_ORDER_SUBMITORDER" }]</button>
                            </div>
                        </form>
                    [{/block}]
                [{/if}]
            [{/if}]
        [{/block}]
    [{/block}]
    [{insert name="oxid_tracker" title=$template_title }]
[{/capture}]

[{assign var="template_title" value="PAGE_CHECKOUT_ORDER_TITLE"|oxmultilangassign}]
[{include file="layout/page.tpl" title=$template_title location=$template_title}]