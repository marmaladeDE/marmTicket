[{capture append="oxidBlock_content"}]

    [{block name="checkout_payment_main"}]
        [{assign var="currency" value=$oView->getActCurrency() }]
        [{block name="checkout_payment_errors"}]
            [{assign var="iPayError" value=$oView->getPaymentError() }]
            [{ if $iPayError == 1}]
                <div class="status error">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_COMLETEALLFIELDS" }]</div>
            [{ elseif $iPayError == 2}]
                <div class="status error">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_AUTHORIZATIONFAILED" }]</div>
            [{ elseif $iPayError == 4 }]
                <div class="status error">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_UNAVAILABLESHIPPING" }]</div>
            [{ elseif $iPayError == 5 }]
                <div class="status error">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_UNAVAILABLEPAYMENT" }]</div>
            [{ elseif $iPayError == 6 }]
                <div class="status error">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_UNAVAILABLETSPROTECTION" }]</div>
            [{ elseif $iPayError > 6 }]
                <!--Add custom error message here-->
                <div class="status error">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_UNAVAILABLEPAYMENT" }]</div>
            [{ elseif $iPayError == -1}]
                <div class="status error">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_ERRUNAVAILABLEPAYMENT" }] "[{ $oView->getPaymentErrorText() }]").</div>
            [{ elseif $iPayError == -2}]
                <div class="status error">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_NOSHIPPINGFOUND" }]</div>
            [{ elseif $iPayError == -3}]
                <div class="status error">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_SELECTANOTHERPAYMENT" }]</div>
            [{/if}]
        [{/block}]

        [{block name="change_payment"}]
            [{oxscript include="js/widgets/oxpayment.js" priority=10 }]
            [{oxscript add="$( '#payment' ).oxPayment();"}]
            [{oxscript include="js/widgets/oxinputvalidator.js" priority=10 }]
            [{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
            <form action="[{ $oViewConf->getSslSelfLink() }]" class="js-oxValidate payment" id="payment" name="order" method="post">
                <div>
                    [{ $oViewConf->getHiddenSid() }]
                    [{ $oViewConf->getNavFormParams() }]
                    <input type="hidden" name="cl" value="[{ $oViewConf->getActiveClassName() }]">
                    <input type="hidden" name="fnc" value="validatepayment">
                </div>

                [{if $oView->getPaymentList()}]
                    <h3 id="paymentHeader" class="blockHead">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_PAYMENT" }]</h3>
                    [{ assign var="inptcounter" value="-1"}]
                    [{foreach key=sPaymentID from=$oView->getPaymentList() item=paymentmethod name=PaymentSelect}]
                        [{ assign var="inptcounter" value="`$inptcounter+1`"}]
                        [{block name="select_payment"}]
                            [{if $sPaymentID == "oxidcashondel"}]
                                [{include file="page/checkout/inc/payment_oxidcashondel.tpl"}]
                            [{elseif $sPaymentID == "oxidcreditcard"}]
                                [{include file="page/checkout/inc/payment_oxidcreditcard.tpl"}]
                            [{elseif $sPaymentID == "oxiddebitnote"}]
                                [{include file="page/checkout/inc/payment_oxiddebitnote.tpl"}]
                            [{else}]
                                [{include file="page/checkout/inc/payment_other.tpl"}]
                            [{/if}]
                        [{/block}]
                    [{/foreach}]

                    [{* TRUSTED SHOPS BEGIN *}]
                    [{include file="page/checkout/inc/trustedshops.tpl"}]
                    [{* TRUSTED SHOPS END *}]

                    [{block name="checkout_payment_nextstep"}]
                        [{if $oView->isLowOrderPrice()}]
                            <div class="lineBox clear">
                            <div><b>[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_MINORDERPRICE" }] [{ $oView->getMinOrderPrice() }] [{ $currency->sign }]</b></div>
                            </div>
                        [{else}]
                            <div class="clear">
                                <br />
                                <a href="[{ oxgetseourl ident=$oViewConf->getOrderLink() }]" class="prevStep submitButton largeButton" id="paymentBackStepBottom">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_BACKSTEP" }]</a>
                                <button type="submit" name="userform" class="submitButton nextStep largeButton" id="paymentNextStepBottom">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_NEXTSTEP" }]</button>
                            </div>
                        [{/if}]
                    [{/block}]

                [{elseif $oView->getEmptyPayment()}]
                    [{block name="checkout_payment_nopaymentsfound"}]
                        <div class="lineBlock"></div>
                        <h3 id="paymentHeader" class="blockHead">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_INFO" }]</h3>
                        [{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_EMPTY_TEXT" }]
                        <input type="hidden" name="paymentid" value="oxempty">
                        <div class="clear">
                            <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user" }]" class="prevStep submitButton largeButton">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_BACKSTEP" }]</a>
                            <button type="submit" name="userform" class="submitButton nextStep largeButton" id="paymentNextStepBottom">[{ oxmultilang ident="PAGE_CHECKOUT_PAYMENT_NEXTSTEP" }]</button>
                        </div>
                    [{/block}]
                [{/if}]
            </form>
        [{/block}]
    [{/block}]
    [{insert name="oxid_tracker" title=$template_title }]
[{/capture}]

[{include file="layout/page.tpl"}]