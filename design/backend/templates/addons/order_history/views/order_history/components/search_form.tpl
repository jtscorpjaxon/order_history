<div class="sidebar-row">
    <h6>{__("search")}</h6>
    <form action="{""|fn_url}" name="history_form" method="get">

        {capture name="simple_search"}
            <div class="sidebar-field">
                <label for="elem_order_id">{__("order_id")}:</label>
                <div class="controls">
                    <input id="elem_order_id" type="text" name="order_id" size="30" value="{$search.order_id}">
                </div>
            </div>

        {/capture}

        {include file="common/advanced_search.tpl"
                 no_adv_link=true
                 simple_search=$smarty.capture.simple_search
                 dispatch="order_history.manage"
                 view_type="order_history"
        }
    </form>
</div>