FROM comics/centos
LABEL maintainer="Maxim Scheremetjew (EMBL-EBI) <maxim@ebi.ac.uk>"

##############################################################
# Software:             hmmer
# Software Version:     3.1b2
# Software Website:     http://hmmer.org/
# Description:          biosequence analysis using profile hidden Markov models
##############################################################

ENV APP_NAME=hmmer
ENV VERSION=3.1b2
ENV DEST=/software/applications/$APP_NAME/
ENV PATH=$DEST/$VERSION/bin:$PATH
ENV MANPATH=$DEST/$VERSION/share/man:$MANPATH

RUN curl -L -o $APP_NAME-$VERSION.tar.gz http://eddylab.org/software/hmmer3/$VERSION/$APP_NAME-$VERSION.tar.gz ; \
    tar xzf $APP_NAME-$VERSION.tar.gz ; \
    cd $APP_NAME-$VERSION ; \
    ./configure --prefix=$DEST/$VERSION ; \
    make -j ; \
    make install ; \
    cd easel ; \
    make install ; \
    cd ../ ;  \
    mkdir -p /usr/share/licenses/$APP_NAME-$VERSION ; \
    cp LICENSE /usr/share/licenses/$APP_NAME-$VERSION/ ; \
    cd ../ ;  \
    rm -rf $APP_NAME-$VESION.tar.gz $APP_NAME-$VERSION ;
CMD ["/bin/bash"]