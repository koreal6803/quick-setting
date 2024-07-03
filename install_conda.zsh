#!/bin/zsh

install_conda() {
    # Check if conda is already installed
    if command -v conda &> /dev/null; then
        echo "Conda is already installed. Skipping installation."
        return 0
    fi

    # Check the operating system
    case "$OSTYPE" in
        linux*)
            echo "Detected Linux OS."
            wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda3-latest-Linux-x86_64.sh
            bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
            ;;
        darwin*)
            echo "Detected macOS."
            wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O Miniconda3-latest-MacOSX-x86_64.sh
            bash Miniconda3-latest-MacOSX-x86_64.sh -b -p $HOME/miniconda
            ;;
        msys*|cygwin*|win32*)
            echo "Detected Windows OS."
            curl -o Miniconda3-latest-Windows-x86_64.exe https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
            start /wait Miniconda3-latest-Windows-x86_64.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%UserProfile%\miniconda
            ;;
        *)
            echo "Unsupported OS type: $OSTYPE"
            exit 1
            ;;
    esac

    # Add Miniconda to PATH
    echo 'export PATH="$HOME/miniconda/bin:$PATH"' >> ~/.zshrc

    # Initialize Conda
    source ~/.zshrc

    # Initialize Conda for the shell
    conda init zsh
}

# Run the install_conda function
install_conda

echo "Conda installation completed or was already installed. Please restart your terminal or run 'source ~/.zshrc' to start using Conda."

