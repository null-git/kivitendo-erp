#=====================================================================
# LX-Office ERP
# Copyright (C) 2004
# Based on SQL-Ledger Version 2.1.9
# Web http://www.lx-office.org
#
######################################################################
# SQL-Ledger Accounting
# Copyright (c) 1998-2002
#
#  Author: Dieter Simader
#   Email: dsimader@sql-ledger.org
#     Web: http://www.sql-ledger.org
#
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#######################################################################

sub create_todo_list {
  $lxdebug->enter_sub();

  my (@todo_items, $todo_list);

  push @todo_items, todo_list_follow_ups();
  push @todo_items, todo_list_overdue_sales_quotations();

  @todo_items = grep { $_ } @todo_items;
  $todo_list  = join("", @todo_items);

  $lxdebug->leave_sub();

  return $todo_list;
}

sub show_todo_list {
  $lxdebug->enter_sub();

  $form->{todo_list} = create_todo_list();
  $form->{title}     = $locale->text('TODO list');

  $form->header();
  print $form->parse_html_template('todo/show_todo_list');

  $lxdebug->leave_sub();
}

sub todo_list_follow_ups {
  $lxdebug->enter_sub();

  require "bin/mozilla/fu.pl";

  my $content = report_for_todo_list();

  $lxdebug->leave_sub();

  return $content;
}

sub todo_list_overdue_sales_quotations {
  $lxdebug->enter_sub();

  require "bin/mozilla/oe.pl";

  my $content = report_for_todo_list();

  $lxdebug->leave_sub();

  return $content;
}

1;
