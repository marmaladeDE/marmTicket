[{assign var="miniBasketList" value=$oxcmp_basket->getContents()}]
[{assign var="currency" value=$oView->getActCurrency()}]
[{if $products|@count gt 0}]
    <table id="productsList">
        [{foreach from=$products item=_product name=productlist}]
                [{include file="widget/product/listitem_starttable.tpl" product=$_product testid=$listId|cat:"_"|cat:$smarty.foreach.productlist.iteration blDisableToCart=$blDisableToCart}]
        [{/foreach}]
        <tr>
            <td colspan="4" align="right">
                <strong>Summe:</strong>
            </td>
            <td>
                <strong>[{if $oxcmp_basket->isPriceViewModeNetto()}]
                [{ $oxcmp_basket->getProductsNetPrice()}]
                [{else}]
                [{ $oxcmp_basket->getFProductsPrice()}]
                [{/if}]
                [{ $currency->sign}] *</strong>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="right" class="last">
                &nbsp;
            </td>
            <td class="last">
                <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket" }]" class="submitButton">
                    <strong>weiter</strong>
                </a>
            </td>
        </tr>
    </table>
    <a
[{/if}]