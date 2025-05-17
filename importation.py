import builtins, fnmatch, os, importlib, traceback, ast
from logging import Logger
logger = Logger('importation')

MODULES_INTERDITS = [
]

MODULES_AUTORISES = [
]

# Sauvegarder l'importation originale
import_original = builtins.__import__

def import_guard(name, globals=None, locals=None, fromlist=(), level=0):
    if any(fnmatch.fnmatch(name, pattern) for pattern in MODULES_AUTORISES):
        return import_original(name, globals, locals, fromlist, level)

    if any(fnmatch.fnmatch(name, pattern) for pattern in MODULES_INTERDITS):
        stack = traceback.extract_stack()
        caller_info = stack[-2]
        logger.warning(
            f"Tentative d'importation interdite : {name}. "
            f"Fichier : {caller_info.filename}, Ligne : {caller_info.lineno}"
        )
        raise ImportError(
            f"L'importation du module '{name}' est interdite. "
            f"Tentative effectuée dans le fichier '{caller_info.filename}', ligne {caller_info.lineno}."
        )

    return import_original(name, globals, locals, fromlist, level)

builtins.__import__ = import_guard

def scan_directory_for_imports(directory_path):
    """Scans all Python files within the specified directory for import statements."""
    if not os.path.isdir(directory_path):
        logger.error(f"Le chemin spécifié '{directory_path}' n'est pas un répertoire valide.")
        return

    for root, _, files in os.walk(directory_path):
        for file in files:
            if file.endswith('.py'):
                file_path = os.path.join(root, file)
                check_file_for_imports(file_path)

def check_file_for_imports(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            source_code = f.read()

        tree = ast.parse(source_code, filename=file_path)
        for node in ast.walk(tree):
            if isinstance(node, ast.Import):
                for alias in node.names:
                    check_import(alias.name, file_path, node.lineno)
            elif isinstance(node, ast.ImportFrom):
                module_name = node.module or ""
                check_import(module_name, file_path, node.lineno)

    except Exception as e:
        logger.error(f"Erreur lors de l'analyse du fichier {file_path}: {e}")

def check_import(module_name, file_path, line_no):
    if any(fnmatch.fnmatch(module_name, pattern) for pattern in MODULES_INTERDITS):
        logger.warning(
            f"Importation interdite détectée : {module_name} "
            f"dans le fichier {file_path}, ligne {line_no}."
        )
    else:
        logger.info(
            f"Importation autorisée : {module_name} "
            f"dans le fichier {file_path}, ligne {line_no}."
        )

# Exemple d'utilisation pour scanner un répertoire spécifique :
if __name__ == "__main__":
    directory_to_scan = "./plugins"  # Remplacez par le chemin réel du répertoire
    scan_directory_for_imports(directory_to_scan)