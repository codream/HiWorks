/**
 * Created with JetBrains RubyMine.
 * User: kent
 * Date: 2013/11/28
 * Time: 下午 5:05
 * To change this template use File | Settings | File Templates.
 */

/*put DIV in scream center*/
function letDivCenter(divName){
    var top = 100;
    var left = ($(window).width() - $(divName).width())/2;
    var scrollTop = $(document).scrollTop();
    var scrollLeft = $(document).scrollLeft();
    $(divName).css( {  position : 'absolute', 'top' : top + scrollTop, left : left + scrollLeft}).show();
}

/*get days in assign month */
function daysInMonth(month,year) {
    var dd = new Date(year, month, 0);
    return dd.getDate();
}
