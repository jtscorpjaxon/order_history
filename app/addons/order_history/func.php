<?php
/***************************************************************************
 *                                                                          *
 *   (c) 2004 Vladimir V. Kalynyak, Alexey V. Vinokurov, Ilya M. Shalnev    *
 *                                                                          *
 * This  is  commercial  software,  only  users  who have purchased a valid *
 * license  and  accept  to the terms of the  License Agreement can install *
 * and use this program.                                                    *
 *                                                                          *
 ****************************************************************************
 * PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
 * "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
 ****************************************************************************/

defined('BOOTSTRAP') or die('Access denied');



/** Change status orders set db order_history
 * @param $order_id
 * @param $old_status
 * @param $new_status
 */
function fn_order_history_change_order_status_post($order_id, $old_status, $new_status, $force_notification, $place_order, $order_info, $edp_data)
{

    $user_id = Tygh::$app['session']['auth']['user_id'];
    $data = array(
        'order_id' => $order_id,
        'old_status' => $old_status,
        'new_status' => $new_status,
        'user_id' => $user_id,
        'timestamp' => TIME
    );

    db_query("INSERT INTO ?:order_history ?e", $data);
}

/** Get list of orders change history
 * @param array $params
 * @return array
 */
function fn_get_order_history($params = array())
{
    $params = array_merge(array(
        'items_per_page' => 0,
    ), $params);

    $fields = array(
        '?:order_history.*',
        '?:users.firstname',
        '?:users.lastname'
    );
    $join = "LEFT JOIN ?:users USING(user_id)";
    $fields_str = implode(', ', $fields);
    $history = db_get_array(
        "SELECT ?p FROM ?:order_history ?p",
        $fields_str, $join
    );
    return array($history, $params);

}
