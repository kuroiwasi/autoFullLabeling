#!/usr/bin/perl
# Copyright (c) 1991-2006 Kawahara Lab., Kyoto University
# Copyright (c) 2000-2005 Shikano Lab., Nara Institute of Science and Technology
# Copyright (c) 2005-2006 Julius project team, Nagoya Institute of Technology, Nagoya Institute of Technology
# All rights reserved
#
# Generated automatically from yomi2voca.pl.in by configure. 
#

# �Ҥ餬�� -> ROMAN(ɸ�����) �Ѵ�������ץ�
#   .yomi -> .voca


while (<>) {
    chomp;
# 3ʸ���ʾ夫��ʤ��Ѵ���§
    s/������/ b a/g;
    s/������/ b i/g;
    s/������/ b e/g;
    s/������/ b o/g;
    s/������/ by u/g;

# 2ʸ������ʤ��Ѵ���§
    s/����/ b u/g;

    s/����/ a a/g;
    s/����/ i i/g;
    s/����/ i e/g;
    s/����/ y a/g;
    s/����/ u:/g;
    s/����/ e e/g;
    s/����/ o:/g;
    s/����/ k a:/g;
    s/����/ k i:/g;
    s/����/ k u:/g;
    s/����/ ky a/g;
    s/����/ ky u/g;
    s/����/ ky o/g;
    s/����/ k e:/g;
    s/����/ k o:/g;
    s/����/ g a:/g;
    s/����/ g i:/g;
    s/����/ g u:/g;
    s/����/ gy a/g;
    s/����/ gy u/g;
    s/����/ gy o/g;
    s/����/ g e:/g;
    s/����/ g o:/g;
    s/����/ s a:/g;
    s/����/ sh i:/g;
    s/����/ s u:/g;
    s/����/ sh a/g;
    s/����/ sh u/g;
    s/����/ sh o/g;
    s/����/ s e:/g;
    s/����/ s o:/g;
    s/����/ z a:/g;
    s/����/ j i:/g;
    s/����/ z u:/g;
    s/����/ zy a/g;
    s/����/ zy u/g;
    s/����/ zy o/g;
    s/����/ z e:/g;
    s/����/ z o:/g;
    s/����/ t a:/g;
    s/����/ ch i:/g;
    s/�Ĥ�/ ts a/g;
    s/�Ĥ�/ ts i/g;
    s/�Ĥ�/ ts u:/g;
    s/�Ĥ�/ ch a/g;
    s/�Ĥ�/ ch u/g;
    s/�Ĥ�/ ch o/g;
    s/�Ĥ�/ ts e/g;
    s/�Ĥ�/ ts o/g;
    s/�Ƥ�/ t e:/g;
    s/�Ȥ�/ t o:/g;
    s/����/ d a:/g;
    s/�¤�/ j i:/g;
    s/�Ť�/ d u:/g;
    s/�Ť�/ zy a/g;
    s/�Ť�/ zy u/g;
    s/�Ť�/ zy o/g;
    s/�Ǥ�/ d e:/g;
    s/�ɤ�/ d o:/g;
    s/�ʤ�/ n a:/g;
    s/�ˤ�/ n i:/g;
    s/�̤�/ n u:/g;
    s/�̤�/ ny a/g;
    s/�̤�/ ny u/g;
    s/�̤�/ ny o/g;
    s/�ͤ�/ n e:/g;
    s/�Τ�/ n o:/g;
    s/�Ϥ�/ h a:/g;
    s/�Ҥ�/ h i:/g;
    s/�դ�/ f u:/g;
    s/�դ�/ hy a/g;
    s/�դ�/ hy u/g;
    s/�դ�/ hy o/g;
    s/�ؤ�/ h e:/g;
    s/�ۤ�/ h o:/g;
    s/�Ф�/ b a:/g;
    s/�Ӥ�/ b i:/g;
    s/�֤�/ b u:/g;
    s/�դ�/ hy a/g;
    s/�֤�/ by u/g;
    s/�դ�/ hy o/g;
    s/�٤�/ b e:/g;
    s/�ܤ�/ b o:/g;
    s/�Ѥ�/ p a:/g;
    s/�Ԥ�/ p i:/g;
    s/�פ�/ p u:/g;
    s/�פ�/ py a/g;
    s/�פ�/ py u/g;
    s/�פ�/ py o/g;
    s/�ڤ�/ p e:/g;
    s/�ݤ�/ p o:/g;
    s/�ޤ�/ m a:/g;
    s/�ߤ�/ m i:/g;
    s/�थ/ m u:/g;
    s/���/ my a/g;
    s/���/ my u/g;
    s/���/ my o/g;
    s/�ᤧ/ m e:/g;
    s/�⤩/ m o:/g;
    s/�䤡/ y a:/g;
    s/�椥/ y u:/g;
    s/���/ y a:/g;
    s/���/ y u:/g;
    s/���/ y o:/g;
    s/�褩/ y o:/g;
    s/�餡/ r a:/g;
    s/�ꤣ/ r i:/g;
    s/�뤥/ r u:/g;
    s/���/ ry a/g;
    s/���/ ry u/g;
    s/���/ ry o/g;
    s/�줧/ r e:/g;
    s/����/ r o:/g;
    s/�嵐/ w a:/g;
    s/��/ o:/g;
    
    s/����/ b u/g;
    s/�Ǥ�/ d i/g;
    s/�Ǥ�/ d e:/g;
    s/�Ǥ�/ dy a/g;
    s/�Ǥ�/ dy u/g;
    s/�Ǥ�/ dy o/g;
    s/�Ƥ�/ t i/g;
    s/�Ƥ�/ t e:/g;
    s/�Ƥ�/ ty a/g;
    s/�Ƥ�/ ty u/g;
    s/�Ƥ�/ ty o/g;
    s/����/ s i/g;
    s/����/ z u a/g;
    s/����/ z i/g;
    s/����/ z u/g;
    s/����/ zy a/g;
    s/����/ zy u/g;
    s/����/ zy o/g;
    s/����/ z e/g;
    s/����/ z o/g;
    s/����/ ky a/g;
    s/����/ ky u/g;
    s/����/ ky o/g;
    s/����/ sh a/g;
    s/����/ sh u/g;
    s/����/ sh e/g;
    s/����/ sh o/g;
    s/����/ ch a/g;
    s/����/ ch u/g;
    s/����/ ch e/g;
    s/����/ ch o/g;
    s/�Ȥ�/ t u/g;
    s/�Ȥ�/ ty a/g;
    s/�Ȥ�/ ty u/g;
    s/�Ȥ�/ ty o/g;
    s/�ɤ�/ d o a/g;
    s/�ɤ�/ d u/g;
    s/�ɤ�/ dy a/g;
    s/�ɤ�/ dy u/g;
    s/�ɤ�/ dy o/g;
    s/�ɤ�/ d o:/g;
    s/�ˤ�/ ny a/g;
    s/�ˤ�/ ny u/g;
    s/�ˤ�/ ny o/g;
    s/�Ҥ�/ hy a/g;
    s/�Ҥ�/ hy u/g;
    s/�Ҥ�/ hy o/g;
    s/�ߤ�/ my a/g;
    s/�ߤ�/ my u/g;
    s/�ߤ�/ my o/g;
    s/���/ ry a/g;
    s/���/ ry u/g;
    s/���/ ry o/g;
    s/����/ gy a/g;
    s/����/ gy u/g;
    s/����/ gy o/g;
    s/�¤�/ j e/g;
    s/�¤�/ j a/g;
    s/�¤�/ j u/g;
    s/�¤�/ j o/g;
    s/����/ j e/g;
    s/����/ j a/g;
    s/����/ j u/g;
    s/����/ j o/g;
    s/�Ӥ�/ by a/g;
    s/�Ӥ�/ by u/g;
    s/�Ӥ�/ by o/g;
    s/�Ԥ�/ py a/g;
    s/�Ԥ�/ py u/g;
    s/�Ԥ�/ py o/g;
    s/����/ u a/g;
    s/����/ w i/g;
    s/����/ w e/g;
    s/����/ w o/g;
    s/�դ�/ f a/g;
    s/�դ�/ f i/g;
    s/�դ�/ f u/g;
    s/�դ�/ hy a/g;
    s/�դ�/ hy u/g;
    s/�դ�/ hy o/g;
    s/�դ�/ f e/g;
    s/�դ�/ f o/g;

# 1������ʤ��Ѵ���§
    s/��/ a/g;
    s/��/ i/g;
    s/��/ u/g;
    s/��/ e/g;
    s/��/ o/g;
    s/��/ k a/g;
    s/��/ k i/g;
    s/��/ k u/g;
    s/��/ k e/g;
    s/��/ k o/g;
    s/��/ s a/g;
    s/��/ sh i/g;
    s/��/ s u/g;
    s/��/ s e/g;
    s/��/ s o/g;
    s/��/ t a/g;
    s/��/ ch i/g;
    s/��/ ts u/g;
    s/��/ t e/g;
    s/��/ t o/g;
    s/��/ n a/g;
    s/��/ n i/g;
    s/��/ n u/g;
    s/��/ n e/g;
    s/��/ n o/g;
    s/��/ h a/g;
    s/��/ h i/g;
    s/��/ f u/g;
    s/��/ h e/g;
    s/��/ h o/g;
    s/��/ m a/g;
    s/��/ m i/g;
    s/��/ m u/g;
    s/��/ m e/g;
    s/��/ m o/g;
    s/��/ r a/g;
    s/��/ r i/g;
    s/��/ r u/g;
    s/��/ r e/g;
    s/��/ r o/g;
    s/��/ g a/g;
    s/��/ g i/g;
    s/��/ g u/g;
    s/��/ g e/g;
    s/��/ g o/g;
    s/��/ z a/g;
    s/��/ j i/g;
    s/��/ z u/g;
    s/��/ z e/g;
    s/��/ z o/g;
    s/��/ d a/g;
    s/��/ j i/g;
    s/��/ z u/g;
    s/��/ d e/g;
    s/��/ d o/g;
    s/��/ b a/g;
    s/��/ b i/g;
    s/��/ b u/g;
    s/��/ b e/g;
    s/��/ b o/g;
    s/��/ p a/g;
    s/��/ p i/g;
    s/��/ p u/g;
    s/��/ p e/g;
    s/��/ p o/g;
    s/��/ y a/g;
    s/��/ y u/g;
    s/��/ y o/g;
    s/��/ w a/g;
    s/��/ i/g;
    s/��/ e/g;
    s/��/ N/g;
    s/��/ q/g;
    s/��/:/g;

# �����ޤǤ˽�������Ƥʤ� ���������� �Ϥ��Τޤ���ʸ������
    s/��/ a/g;
    s/��/ i/g;
    s/��/ u/g;
    s/��/ e/g;
    s/��/ o/g;
    s/��/ w a/g;
    s/��/ o/g;

#����¾���̤ʥ롼��
    s/��/ o/g;

    s/^ ([a-z])/$1/g;
    s/:+/:/g;

    if (! /^[ a-zA-Z:]+$/) {
	print STDERR "$_\n";
    }

    print "$_\n";

}
