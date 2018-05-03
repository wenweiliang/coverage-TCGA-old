library( "ggplot2" )
#library("ggdendro")
library( "RColorBrewer" )

get_val_arg = function( args , flag , default ) {
	ix = pmatch( flag , args ); #partial match of flag in args, returns index in argument list
	if ( !is.na( ix ) ) { #ix is a pmatch of flag in args
		if ( is.numeric( default ) ) {
			val = as.numeric( args[ix+1] );
		} else {
			val = args[ix+1];
		}
	} else {
		val = default;
	}
	return( val );
}

get_bool_arg = function( args , flag ) {
	ix = pmatch( flag , args );
	if ( !is.na( ix ) ) {
		val = TRUE;
	} else {
		val = FALSE;
	}
	return( val );
}

get_list_arg = function( args , flag , nargs , default ) {
	ix = pmatch( flag , args ); #partial match of flag in args
	vals = 1:nargs;
	if ( !is.na( ix ) ) { #ix is a pmatch of flag in args
		for ( i in 1:nargs ) {
			if ( is.numeric( default ) ) {
				vals[i] = as.numeric( args[ix+i] );
			} else {
				vals[i] = args[ix+i];
			}
		}
	} else {
		for ( i in 1:nargs ) {
			vals[i] = default;
		}
	}
	return( vals );
}


parse_args = function() {
	args = commandArgs( trailingOnly = TRUE ); #tailingOnly = TRUE, arguments after --args are returned

#default setting
	title = get_val_arg( args , "-t" , "" );
	height = get_val_arg( args , "-h" , 8 );
	width = get_val_arg( args , "-w" , 6 );
	vlabel = get_val_arg( args , "-y" , "" );
	hlabel = get_val_arg( args , "-x" , "" );

	output = args[length( args )];  args = args[-length( args )];
	dat = args[length( args )]; args = args[-length( args )];

	val = list( 'dat' = dat ,
				'output' = output ,
				'title' = title ,
				'height' = height ,
				'width' = width ,
				'vlabel' = vlabel ,
				'hlabel' = hlabel );

	return( val );
}

#get args
args = parse_args();

dat = args$dat;     data = read.table( file = dat , header = TRUE , sep = "\t", na.string=TRUE );
output = args$output;
title = args$title;
h = args$height;
w = args$width;
vlab = args$vlabel;
hlab = args$hlabel;

#The previous codes just want to parse the command line the user put in.
p = ggplot( data = data, aes( x=Distance_to_Start, y=Average_Read_Depth, color=Region))+ geom_line()+xlim(0,500)+ylim(0,120)
#specify the field you want from input data. (x-axis(categories), y-axis, flag))
#p = p + geom_violin( data = data, scale="width", alpha = 0.5, ) 
#p = p + geom_jitter( data = data, stackdir='center', alpha = 0.8, dotsize=0.3, );
#p = p + stat_summary(data = data, color="gray25", fun.xmin=median, fun.xmax=median, geom="errorbar", size=1,) 

p = p + theme_bw( );
p = p + theme( panel.grid = element_blank() ); #no x minor grid lines

p = p + theme( axis.text.x = element_text( hjust = 1 , vjust = 0.5 , angle = 90 ) ); #no x grid labels
p = p + theme( panel.grid.minor.x = element_blank() ); #no x minor grid lines
p = p + xlab( hlab );

p = p + theme( panel.grid.minor.y = element_blank() ); #no x minor grid lines
p = p + theme( axis.text.y = element_text( hjust = 1 , vjust = 0.5 ) ); #no x grid labels
p = p + ylab( vlab );

p = p + theme( legend.position='bottom') 

cat( sprintf( "\tSaving to %s ... " , output ) );
ggsave( output , height = h , width = w );
cat( sprintf( "Saved!\n" ) );
unlink( "Rplots.pdf" );

