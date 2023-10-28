def r_add_quota(text):
    if " " not in text:
        return text
    return f"{' '.join(text.split(' ')[:1])} \"{' '.join(text.split(' ')[1:])}\""


def r_add_quota_warp(text):
    return f'"{text}"'
