[{capture append="oxidBlock_content"}]

    [{* ordering steps *}]

    [{block name="checkout_basket_main"}]
        [{assign var="currency" value=$oView->getActCurrency() }]
        [{if !$oxcmp_basket->getProductsCount()  }]
            [{block name="checkout_basket_emptyshippingcart"}]
                <div class="status corners error">[{ oxmultilang ident="PAGE_CHECKOUT_BASKET_EMPTYSHIPPINGCART" }]</div>
            [{/block}]
        [{else }]
            [{include file="page/checkout/inc/visitordata.tpl" editable=true}]

            [{block name="basket_btn_next_bottom"}]
                <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
                    [{ $oViewConf->getHiddenSid() }]
                    <input type="hidden" name="cl" value="user">
                    <button type="submit" class="submitButton largeButton nextStep">[{ oxmultilang ident="PAGE_CHECKOUT_BASKET_NEXTSTEP" }]</button>
                </form>
            [{/block}]
        [{/if }]
    [{/block}]
    [{insert name="oxid_tracker" title=$template_title }]
[{/capture}]

[{include file="layout/page.tpl"}]