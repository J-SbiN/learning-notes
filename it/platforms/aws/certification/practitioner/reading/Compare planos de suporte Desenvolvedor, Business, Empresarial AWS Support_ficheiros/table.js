define(function(){"use strict";var defaults={pageNavSelector:"#aws-page-header",stickyTableClass:"lb-sticky-tbl",isStickyHeader:false};function Table(elem){this.$elem=$(elem);this.options=$.extend({},defaults,this.$elem.data());if(this.options.isStickyHeader){this.$table=this.$elem.children("table");this.$rows=this.$table.find("tr");this.$header=this.$rows.eq(0);this.$headerCols=this.$header.children("td");this.$pageNav=$(this.options.pageNavSelector);this.$stickyTable=this.$table.clone();this.$stickyHeader=this.$header.clone();this.$stickyTable.hide().find("tbody").html(this.$stickyHeader);this.$stickyTable.addClass(this.options.stickyTableClass).insertBefore(this.$table);this.$stickyHeaderCols=this.$stickyHeader.find("td");this.bindHandler();this.resizeStickyTable();this.renderStickyTable()}}Table.prototype={bindHandler:function(){var that=this;$(window).on("resize",function(){that.resizeStickyTable();that.renderStickyTable()});$(window).scroll(function(){that.renderStickyTable()});setTimeout(function(){that.resizeStickyTable();that.renderStickyTable()},200)},resizeStickyTable:function(){var that=this;this.$stickyTable.css("width",this.$table.width());this.$stickyHeaderCols.each(function(index){$(this).css("width",that.$headerCols.eq(index).outerWidth())})},getNavHeight:function(){var $pageNav=this.$pageNav;if($pageNav.length>0&&$pageNav.css("position")==="fixed"){return $pageNav.height()}return 0},getStickyCSSPosition:function(){var isTableHidden=this.$table.is(":hidden");var masked=this.tableMaskedCheck();if(masked.y||isTableHidden){return null}else if(masked.x){return"absolute"}return"fixed"},tableMaskedCheck:function(){var masked={};var currentWidth;var currentHeight;var previousWidth=this.$table.outerWidth();var previousHeight=this.$table.outerHeight();this.$table.parents().each(function(){if(this===document.body){return false}currentWidth=$(this).outerWidth();currentHeight=$(this).outerHeight();if(currentWidth<previousWidth&&!masked.x){masked.x=true}else{previousWidth=currentWidth}if(currentHeight<previousHeight){masked.y=true}else{previousHeight=currentHeight}if(masked.y){return false}});return masked},renderStickyTable:function(){var left="auto";var position=this.getStickyCSSPosition();var fixedNavHeight=this.getNavHeight();var offsetX=$(window).scrollLeft();var offsetY=$(window).scrollTop();var tableOffsetTop=this.$table.offset().top-fixedNavHeight;var tableOffsetBottom=tableOffsetTop+this.$table.height()-this.$header.height();var isTableViewable=offsetY>=tableOffsetTop&&offsetY<=tableOffsetBottom;var showTable=isTableViewable&&position;if(this.$stickyTable.width()===0){this.$stickyTable.css("width",this.$table.width())}if(showTable){if(position==="fixed"){if(offsetX){left=this.$table.offset().left-offsetX}this.$stickyTable.css({display:"table",position:position,top:fixedNavHeight,left:left})}else{this.$stickyTable.css({display:"table",position:position,top:offsetY-tableOffsetTop,left:left})}}else if(this.$stickyTable.css("display")!=="none"){this.$stickyTable.css({display:"none"})}}};Libra.Comp.register({name:"table",initFct:function(elem){new Table(elem)},initTime:"immediate"});return Table});