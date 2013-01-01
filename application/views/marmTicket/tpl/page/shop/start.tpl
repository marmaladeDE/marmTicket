[{capture append="oxidBlock_content"}]
    [{if $oView->getNewestArticles() }]
        [{include file="widget/product/list.tpl" products=$oView->getNewestArticles() showMainLink=true}]
        
    [{/if}]
[{ insert name="oxid_tracker"}]
[{/capture}]
[{include file="layout/page.tpl"}]