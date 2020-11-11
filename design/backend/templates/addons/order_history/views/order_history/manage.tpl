{capture name="mainbox"}

    <form action="{""|fn_url}" method="post" name="banners_form" class=" cm-hide-inputs" enctype="multipart/form-data">
        <input type="hidden" name="fake" value="1" />

        {assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}


        {assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
        {assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

        {if $history}
            <div class="table-responsive-wrapper">
                <table class="table table-middle table--relative table-responsive">
                    <thead>
                    <tr>
                        <th width="6%" class="left mobile-hide">

                            {include file="common/check_items.tpl" check_statuses=$order_status_descr}
                            <input type="checkbox"
                                   class="bulkedit-toggler hide"
                                   data-ca-bulkedit-toggler="true"
                                   data-ca-bulkedit-disable="[data-ca-bulkedit-default-object=true]"
                                   data-ca-bulkedit-enable="[data-ca-bulkedit-expanded-object=true]"
                            />
                        </th>
                        <th width="15%"><a class="cm-ajax" href="{"`$c_url`&sort_by=order_id&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("id")}{if $search.sort_by == "order_id"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                        <th width="15%"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("order_history.old_status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                        <th width="15%"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("order_history.new_status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                        <th width="17%"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("user")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                        <th width="15%"><a class="cm-ajax" href="{"`$c_url`&sort_by=date&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("date")}{if $search.sort_by == "date"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>



                        <th class="mobile-hide">&nbsp;</th>


                    </tr>
                    </thead>

                    <tbody>
                    {foreach from=$history item="h"}
                        <tr>

                        <tr class="cm-longtap-target"
                            data-ca-longtap-action="setCheckBox"
                            data-ca-longtap-target="input.cm-item"
                            data-ca-id="{$h.order_id}"
                        >
                            <td width="6%" class="left mobile-hide">
                                <input type="checkbox" name="order_ids[]" value="{$h.order_id}" class="cm-item cm-item-status-{$h.status|lower} hide" /></td>
                            <td width="15%" data-th="{__("id")}">
                                <a href="{"orders.details?order_id=`$h.order_id`"|fn_url}" class="underlined">{__("order")} <bdi>#{$h.order_id}</bdi></a>
                            </td>
                            <td width="25%" data-th="{__("old-status")}">
                                <div class="status-block">
                                    <span class="btn btn-info o-status-{$h.old_status|lower} order-status btn-small btn dropdown-toggle cm-combination dropdown-toggle--text-wrap ">{$statuses[$h.old_status] }</span>
                                </div>
                            </td>
                            <td width="25%" data-th="{__("new-status")}">
                                <div class="status-block">
                                    <span class="btn btn-info o-status-{$h.new_status|lower} order-status btn-small btn dropdown-toggle cm-combination dropdown-toggle--text-wrap">{$statuses[$h.new_status]}</span>
                                </div>
                            </td>

                            <td width="17%" data-th="{__("customer")}">
                                {if $h.user_id}<a href="{"profiles.update?user_id=`$h.user_id`"|fn_url}">{/if}{$h.lastname} {$h.firstname}{if $h.user_id}</a>{/if}
                            </td>
                            <td width="27%" class="nowrap" data-th="{__("date")}">{$h.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        {else}
            <p class="no-items">{__("no_data")}</p>
        {/if}

    </form>

{/capture}

{capture name="sidebar"}
    {include file="addons/order_history/views/order_history/components/search_form.tpl" dispatch="order_history.manage"}
{/capture}



{include file="common/mainbox.tpl" title=__("order_history") content=$smarty.capture.mainbox buttons=$smarty.capture.buttons sidebar=$smarty.capture.sidebar content_id="order_history"  }